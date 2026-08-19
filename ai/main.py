from data_loader import load_view

from insight_generator import generate_executive_insights

from report_generator import save_report

monthly = load_view("vw_ai_monthly_summary")

category = load_view("vw_ai_category_summary")

traffic = load_view("vw_ai_traffic_summary")

products = load_view("vw_ai_top_products")

executive = load_view("vw_ai_executive_summary")

insights = generate_executive_insights(

    monthly,

    category,

    traffic,

    products,

    executive

)

for item in insights:

    print(item)

save_report(insights)