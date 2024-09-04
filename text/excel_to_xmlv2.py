import os
import openpyxl
import xml.etree.ElementTree as ET
import logging

def get_filename_without_extension(path):
    return path.split("/")[-1].split(".")[0]

dict_ = {
    "DF_01": {},
    "DF_02": {},
    "DF_03": {},
    "DF_04": {},
    "DF_05": {},
    "SEI_01": {},
    "SEI_02": {},
    "SEI_03": {},
    "SEI_04": {},
    "SEI_05": {},
    "SEI_06": {},
    "SEI_07": {},
}

class CustomFormatter(logging.Formatter):
    grey = "\x1b[38;20m"
    yellow = "\x1b[33;20m"
    red = "\x1b[31;20m"
    redBold = "\x1b[31;1m"
    green = "\x1b[36;20m"
    reset = "\x1b[0m"
    formatText = "[%(name)s]\t%(message)s"

    formats = {
        logging.DEBUG: grey + "[调试] " + formatText + reset,
        logging.INFO: green + "[信息] " + formatText + reset,
        logging.WARNING: yellow + "[警告] " + formatText + reset,
        logging.ERROR: red + "[错误] " + formatText + reset,
        logging.CRITICAL: redBold + "[严重] " + formatText + reset
    }

    def format(self, record):
        formatLog = self.formats[record.levelno]
        formatter = logging.Formatter(formatLog)
        return formatter.format(record)

checker = logging.getLogger("打包检查")
handler = logging.StreamHandler()
handler.setFormatter(CustomFormatter())
checker.addHandler(handler)

checker.setLevel(logging.INFO)

def highlight(text, need_highlight_text):
    if isinstance(need_highlight_text, list):
        text_ = text
        for h in need_highlight_text:
            text_ = text_.replace(h, f"\033[1;31;40m{h}\033[0;31;40m")
        return text_
    else:
        return text.replace(need_highlight_text, f"\033[1;31;40m{need_highlight_text}\033[0;31;40m")

def highlight_2(text, one, two):
    text_ = text.replace(one, f"\033[1;31;40m{one}\033[0;31;40m")
    text_ = text_.replace(two, f"\033[1;32;40m{two}\033[0;32;40m")


def parse_xlsx(xlsx_path):
    name = get_filename_without_extension(xlsx_path)
    wb = openpyxl.load_workbook(xlsx_path)
    checker.info(f"正在分析 {name}")
    print()
    ws = wb.active
    debug, info, warning, error, critical = 0, 0, 0, 0, 0
    for index, row in enumerate(ws.iter_rows()):
        if index == 0:
            continue
        if row[0].value is None:
            continue
        filename = row[0].value
        _page_title = row[1].value
        index_ = row[2].value
        raw = row[3].value
        trans = row[4].value
        if not trans:
            # print(f"{name} {index_}: No translation, use raw text")
            trans = raw
        else:
            pass
            # print(f"{name} {index_}: {raw} -> {trans}")
        if trans != raw:
            if "bb" in trans:
                checker.info(f"{name} {index_}: 存在 Readstop 符号。")
                checker.info(f"原文：{raw}")
                checker.info(f"翻译：{highlight(trans, 'bb')}")
                info += 1
                print()

            # if raw.startswith("　") and not trans.startswith("　"):
            #     trans = "　" + trans.strip()
            if trans.startswith("　"):
                checker.warning(f"{name} {index_}: 翻译以全角空格起手。")
                checker.warning(f"原文：{raw}")
                checker.warning(f"翻译：{highlight(trans, '　')}")
                warning += 1
                print()
                trans = "　　" + trans.rstrip()
            else:
                trans = "　　" + trans.strip()

            # 统一化 say here -> sayhere
            if "say here" in trans:
                trans = trans.replace("say here", "sayhere")
            trans = trans.replace(" ", "")

            if raw.strip().startswith("「") and not trans.strip().startswith("“"):
                checker.error(f"{name} {index_}: 未使用引号起手。")
                checker.error(f"原文：{highlight(raw, "「")}")
                checker.error(f"翻译：{trans}")
                # error += 1
                print()

            double_quotes_left = trans.count("“")
            double_quotes_right = trans.count("”")

            single_quotes_left = trans.count("‘")
            single_quotes_right = trans.count("’")

            del_single = 0

            if "’s" in trans:
                del_single = 1

            if double_quotes_left != double_quotes_right or ((double_quotes_left + double_quotes_right) % 2 != 0):
                checker.error(f"{name} {index_}: 左右双引号不匹配或未闭合。")
                checker.error(f"左双引号: {double_quotes_left}，右双引号: {double_quotes_right}")
                checker.error(f"原文：{raw}")
                checker.error(f"翻译：{highlight_2(trans, "“", "”")}")

            if single_quotes_left != single_quotes_right - del_single or ((single_quotes_left + single_quotes_right - del_single) % 2 != 0):
                checker.error(f"{name} {index_}: 左右单引号不匹配或未闭合。")
                checker.error(f"左单引号: {single_quotes_left}，右单引号: {single_quotes_right}")
                checker.error(f"原文：{raw}")
                checker.error(f"翻译：{highlight_2(trans, "‘", "’")}")

            half_sheng_hao = trans.count("…")
            full_sheng_hao = trans.count("……")

            if half_sheng_hao % 2 != 0 or half_sheng_hao / 2 != full_sheng_hao:
                checker.error(f"{name} {index_}: 省略号未符合要求。")
                checker.error(f"半省略号: {half_sheng_hao}，全省略号: {full_sheng_hao}")
                checker.error(f"原文：{raw}")
                checker.error(f"翻译：{trans}")
                # error += 1
                print()

            if "\"" in trans or "\'" in trans:
                checker.warning(f"{name} {index_}: 使用了英文引号。")
                checker.warning(f"原文：{raw}")
                checker.warning(f"翻译：{trans}")
                warning += 1
                print()

            if "「" in trans or "」" in trans or "『" in trans or "』" in trans:
                checker.warning(f"{name} {index_}: 使用了全角引号。")
                checker.warning(f"原文：{raw}")
                checker.warning(f"翻译：{highlight(trans, ["」", "「", "『", "』"])}")
                warning += 1
                print()

            if "＜" in raw:
                left_angle_bracket = trans.count("＜")
                right_angle_bracket = trans.count("＞")

                if "＜" not in trans:
                    checker.warning(f"{name} {index_}: 未使用全角尖括号。")
                    checker.warning(f"原文：{highlight(raw, ["＜", "＞"])}")
                    checker.warning(f"翻译：{trans}")
                    warning += 1
                    print()

                if left_angle_bracket != right_angle_bracket or (left_angle_bracket + right_angle_bracket) % 2 != 0:
                    checker.error(f"{name} {index_}: 全角尖括号未闭合。")
                    checker.error(f"左尖括号: {left_angle_bracket}，右尖括号: {right_angle_bracket}")
                    checker.error(f"原文：{highlight(raw, ["＜", "＞"])}")
                    checker.error(f"翻译：{trans}")
                    # error += 1
                    print()

        # print(row)
        dict_[filename][index_] = trans
    checker.info(f"分析完成 {name}，共 {info} 个信息，{warning} 个警告，{error} 个错误，{critical} 个严重错误。")
    if error > 0 or critical > 0:
        checker.critical(f"存在错误，无法继续分析。")
        exit(1)
    checker.info("-------------------- 分析完成 --------------------")


for file in os.listdir("./"):
    if file.endswith(".xlsx") and not file.startswith("~"):
        parse_xlsx("./" + file)


for name, items in dict_.items():
    tree = ET.parse(f"{name}.xml")
    for index, child in enumerate(tree.getroot().iter()):
        if child.tail and child.tail.strip():
            if index in items:
                child.tail = items[index]
            else:
                pass
                # print(f"{name} {index}: No index in xlsx")
    tree.write(f"./{name}_translated.xml", encoding="utf-8", xml_declaration=True)
    with open(f"./{name}_translated.xml", "r", encoding="utf-8") as f:
        content = f.read()
    with open(f"./{name}_translated.xml", "w+", encoding="utf-8") as f:
        f.write(content.replace("bb", "<readstop />"))
