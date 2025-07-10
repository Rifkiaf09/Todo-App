# To-Do List App ✅

A simple and functional To-Do List application built with **Flutter** and integrated with **Firebase Authentication** and **local notifications**.

## 📱 Features

- 🔐 User login & registration with **Firebase Authentication**
- 🗓️ Add, update, and delete to-do items with deadlines
- 🔔 **Local notification reminders** for tasks
- 🌙 **Dark mode / light mode** toggle
- 🔓 Automatic login if user is already signed in
- 🔒 Secure logout functionality
- 🧠 Clean UI with task categorization and filtering *(on progress)*

## 🛠️ Tech Stack

- **Flutter** (Frontend)
- **Firebase Authentication** (Login & Register)
- **Flutter Local Notifications** (Task reminders)
- **SQLite** *(planned for offline data storage)*

# To-Do List App ✅

A simple and functional To-Do List application built with **Flutter** and integrated with **Firebase Authentication** and **local notifications**.

## 📱 Features

- 🔐 User login & registration with **Firebase Authentication**
- 🗓️ Add, update, and delete to-do items with deadlines
- 🔔 **Local notification reminders** for tasks
- 🌙 **Dark mode / light mode** toggle
- 🔓 Automatic login if user is already signed in
- 🔒 Secure logout functionality
- 🧠 Clean UI with task categorization and filtering *(on progress)*

## 🛠️ Tech Stack

- **Flutter** (Frontend)
- **Firebase Authentication** (Login & Register)
- **Flutter Local Notifications** (Task reminders)
- **SQLite** *(planned for offline data storage)*

## 📂 Project Structure

lib/
│
├── helpers/
│ └── notification_helper.dart # Local notification setup
│
├── models/
│ └── todo_model.dart # ToDo item model
│
├── pages/
│ ├── login_page.dart # Login UI
│ ├── register_page.dart # Registration UI
│ └── home_page.dart # Main To-Do screen
│
├── firebase_options.dart # Auto-generated config from Firebase
└── main.dart # App entry point with theme and routing
