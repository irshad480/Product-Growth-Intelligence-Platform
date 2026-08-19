"""
Report Generator
"""

from pathlib import Path


def save_report(insights):

    report = Path("Executive_Report.md")

    with open(report, "w", encoding="utf-8") as f:

        f.write("# Executive Business Report\n\n")

        for insight in insights:

            f.write(f"- {insight}\n")

    print("Report Generated Successfully")