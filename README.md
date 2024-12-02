# **Todo List App**

A simple, efficient, and user-friendly Flutter-based Todo List application that helps you organize your tasks with powerful features like priority management, task persistence, and a responsive design.

---

## **Features**

- **Create and Manage Tasks**:
  - Add tasks with a title, description, due date, and priority.
  - Edit tasks anytime.
  - Mark tasks as completed or incomplete.
  - Delete tasks with a swipe action.
- **Priority Levels**:
  - Set task priorities (Low, Medium, High) with visual indicators.
- **Task Persistence**:
  - Automatically saves tasks locally using SharedPreferences.
  - Tasks remain intact even after app restarts.
- **Responsive Design**:
  - Optimized for mobile and tablet devices.
- **Seamless State Management**:
  - Built with GetX for efficient and reactive state management.

---

## **Preview**

| **Task List View**                  |
|-------------------------------------|
|    https://github.com/user-attachments/assets/15d44abb-2d80-489a-b942-6e76e8548af6 |
---

## **Getting Started**

### **Prerequisites**
- **Flutter**: Ensure Flutter SDK is installed. [Get Flutter](https://flutter.dev/docs/get-started/install)
- **Dart**: Dart SDK comes bundled with Flutter.

### **Installation**
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/todo-list-app.git
   cd todo-list-app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

---

## **Usage**

### **Add a Task**
1. Click the **+** button on the main screen.
2. Fill out the task details (title, description, priority, and due date).
3. Click **Create Task** to save it.

### **Edit a Task**
1. Tap on an existing task from the list.
2. Update the desired fields.
3. Click **Update Task** to save changes.

### **Mark Task as Completed**
- Tap the checkbox next to the task to mark it as complete or incomplete.

### **Delete a Task**
- Swipe a task to the left to delete it.

---

## **Tests**

### **Run Tests**
Execute unit and widget tests to verify app functionality:
```bash
flutter test
```

### **Test Coverage**
- **Unit Tests**:
  - Covers core functionality of the `TodoController`.
- **Widget Tests**:
  - Ensures proper UI rendering for `AddTaskDetailView` and `TodoView`.

---

## **Dependencies**
| Dependency          | Version | Purpose                                   |
|---------------------|---------|-------------------------------------------|
| **Flutter SDK**     | Latest  | Base framework                            |
| **GetX**            | ^4.6.6  | State management                          |
| **SharedPreferences** | ^2.2.2 | Persistent local storage                  |
| **intl**            | ^0.18.0 | Date formatting for task due dates        |

---

## **Folder Structure**

```plaintext
lib/
├── controller/      # Business logic controllers (e.g., TodoController)
├── data/            # Data models (e.g., TodoModel)
├── view/            # UI components and screens (e.g., AddTaskDetailView, TodoView)
└── main.dart        # App entry point
```

---

## **Potential Future Enhancements**
- **Task Filtering**: Filter tasks by completed or pending status.
- **Advanced Storage**: Switch to Hive or SQLite for structured data storage.
- **Notifications**: Add reminders for task due dates.
- **Recurring Tasks**: Allow tasks to repeat daily, weekly, or monthly.
- **Tagging**: Add support for categorizing tasks.

---

## **Contributing**
I welcome contributions! Follow these steps to contribute:
1. Fork the repository.
2. Create a new branch for your feature:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature description"
   ```
4. Push the changes and create a Pull Request:
   ```bash
   git push origin feature-name
   ```

## **Contact**
- **Author**: Abdallah Swify 
- **GitHub**: [roshdology123](https://github.com/yourusername)  
- **Email**: abdallahelswify@gmail.com

Feel free to reach out with feedback or suggestions! 😊
