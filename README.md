## Used Xcode 16.3
📱 iOS Interview Project Task: E-Commerce Product Browser
🧪 Complexity: Moderate
 ⏰ Estimated Duration: 6 Hours
 📦 Deliverables: Xcode Project ZIP + short screen recording or screenshots
 ⚠️ Note: Use of AI tools is strictly not allowed for this task. Submissions that show signs of AI-generated content or code will be disqualified. 🚫

🎯 Objective
Build a Swift-based iOS app using clean architecture (MVVM preferred) that includes authentication, a modern product browsing experience, and a filtering mechanism, powered by Platzi Fake Store API.

🖼️ Screens to Implement (3 Total)

1️⃣ Login Screen
Fields: Email & Password


Button: Login


API Call:
 POST https://api.escuelajs.co/api/v1/auth/login
 Example request:

 json
CopyEdit
{
  "email": "john@mail.com",
  "password": "changeme"
}
On Success:


Save access token securely


Fetch user profile:
 GET /api/v1/auth/profile


Error Handling: Show validation or API error



2️⃣ Home Screen
🔁 Top Horizontal Category Scroller
Show category name & image


API: GET /categories


On tap → apply filter in product list


🧾 Full Product List (Vertical)
List of all products (or filtered by category). Show as Grid (2 products in a Row with vertical scroll and Pagination).


Includes title, price, description, and image (GIF placeholder)


Pull-to-refresh


Pagination using:
 ?offset=0&limit=10, ?offset=10&limit=10, etc.


Tapping product: Show product details (optional)


🧠 Additional UI:
Search bar at top
Filter icon to open filter screen
Logout icon to open confirmation popup and redirect to logout screen and clear all preferences.



3️⃣ Filter Screen
Accessed via filter icon on Home Screen


Fields:


Category: Drop-down (populate using GET /categories)


Price Range: Min and Max text fields or sliders


Actions:


Apply Filters


Clear Filters


Filters affect Home Screen product list using query:



/products?price_min=100&price_max=500&categoryId=3

✅ Required Features
MVVM (preferred), separation of concerns


Loading / empty / error UI states


GIF loading placeholder support


Pull-to-refresh


Pagination


Token-based auth handling



🔧 Optional Bonus (for extra points)
Shimmer or skeleton loaders


Search-as-you-type


