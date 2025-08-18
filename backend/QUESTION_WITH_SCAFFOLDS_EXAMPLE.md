# Question Creation with Scaffolds

## New Endpoint

**POST** `/api/v1/questions?include=scaffolds`

This endpoint allows you to create a question with scaffolds in a single request.

## Example Payloads

### Multiple Choice Question with Scaffolds

```json
{
  "type": "MULTIPLE_CHOICE",
  "question_text": "What is inheritance in Object-Oriented Programming?",
  "hint_level_1": "Think about how one class can use properties from another class.",
  "hint_level_2": "Inheritance allows a class to inherit properties and methods from another class.",
  "options": [
    {
      "option_key": "A",
      "option_text": "A way to create multiple objects from a class",
      "option_explanation": "This describes instantiation, not inheritance"
    },
    {
      "option_key": "B",
      "option_text": "A mechanism that allows a class to inherit properties and methods from another class",
      "option_explanation": "Correct! This is the definition of inheritance"
    },
    {
      "option_key": "C",
      "option_text": "A way to hide data from other classes",
      "option_explanation": "This describes encapsulation, not inheritance"
    },
    {
      "option_key": "D",
      "option_text": "A method to organize code into packages",
      "option_explanation": "This describes packaging, not inheritance"
    }
  ],
  "correct_option_key": "B",
  "scaffolds": [
    {
      "scaffoldText": "What is the class that **other classes inherit from** called?",
      "scaffoldCorrectAnswer": "Superclass or parent class",
      "orderIndex": 0
    },
    {
      "scaffoldText": "What is the class that **inherits from another class** called?",
      "scaffoldCorrectAnswer": "Subclass or child class",
      "orderIndex": 1
    }
  ]
}
```

### Written Question with Scaffolds

```json
{
  "type": "WRITTEN",
  "question_text": "Explain the concept of polymorphism in Object-Oriented Programming.",
  "hint_level_1": "Think about how the same method can behave differently in different contexts.",
  "hint_level_2": "Polymorphism allows objects of different classes to respond to the same method call in different ways.",
  "correct_answer_text": "Polymorphism is the ability of different objects to respond to the same method call in different ways. It allows one interface to be used for a general class of actions, with the specific action determined by the exact nature of the situation.",
  "answer_explanation": "This explanation covers the key concept: same interface, different implementations.",
  "scaffolds": [
    {
      "scaffoldText": "Can you give an example of a method that might behave differently depending on the object type?",
      "scaffoldCorrectAnswer": "Examples include: the 'move' method (car moves on wheels, fish moves by swimming), or the 'makeSound' method (dog barks, cat meows).",
      "orderIndex": 0
    },
    {
      "scaffoldText": "What is the relationship between inheritance and polymorphism?",
      "scaffoldCorrectAnswer": "Inheritance provides the foundation for polymorphism by allowing different classes to share a common interface while implementing specific behaviors.",
      "orderIndex": 1
    }
  ]
}
```

## How It Works

1. **Question Creation**: The question is first saved without scaffolds
2. **Scaffold Creation**: Each scaffold is then created and linked to the question
3. **Response**: Returns the complete question with scaffolds

## Notes

- The `orderIndex` field in scaffolds is optional - if not provided, the system automatically assigns the next available position
- All existing validation rules still apply
- Requires ADMIN role authentication
- Scaffolds are created in the order they appear in the array
