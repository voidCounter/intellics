--
-- PostgreSQL database dump
--

\restrict 93BEPnLoz40z26UXYtQrRvNlYuxnDrGhMYlEMkaZTnMltwimC5rCCycL1uHq6vs

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: experimental_strategies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.experimental_strategies (strategy_id, strategy_name, description, is_active, created_at, updated_at) VALUES ('f4f36107-3f2b-4195-8f36-c598c165ac6a', 'CONTROL', 'Control group: Only QUESTION_ATTEMPTED interactions update mastery', true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.experimental_strategies (strategy_id, strategy_name, description, is_active, created_at, updated_at) VALUES ('f145f688-5563-4cc1-94d9-23df87624fa0', 'HINT_SUPPORT', 'Hint support group: QUESTION_ATTEMPTED + HINT_REQUESTED interactions update mastery', true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.experimental_strategies (strategy_id, strategy_name, description, is_active, created_at, updated_at) VALUES ('f67211d0-d3d4-496f-9764-29a130b6c6f7', 'SCAFFOLD_SUPPORT', 'Scaffold support group: QUESTION_ATTEMPTED + SCAFFOLD_ATTEMPTED interactions update mastery', true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.experimental_strategies (strategy_id, strategy_name, description, is_active, created_at, updated_at) VALUES ('b0b8f0ae-94e1-43a9-8b9c-97b966e1d5f0', 'FULL_SUPPORT', 'Full support group: QUESTION_ATTEMPTED + HINT_REQUESTED + SCAFFOLD_ATTEMPTED interactions update mastery', true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');


--
-- Data for Name: knowledge_components; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('f947c4d8-c88b-4522-acd2-59d9cf755d48', 'This KC covers the fundamental concept of inheritance, where a new class (subclass) derives properties and behaviors from an existing class (superclass). It`s crucial for code reusability and establishing hierarchical relationships between classes. A learner can demonstrate mastery by correctly using the `extends` keyword (or equivalent in other languages) to create a subclass and explain its benefits, such as a `Car` class inheriting from a `Vehicle` class.', 'Defining and Applying Class Inheritance', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'This KC involves understanding abstraction as the process of hiding complex implementation details and showing only the essential features of an object. In OOP, this is often achieved using abstract classes and methods, which define a common interface but leave implementation to subclasses. Mastery is shown by correctly defining an abstract `Shape` class with an abstract `calculateArea()` method, and then implementing specific area calculations in `Circle` and `Rectangle` subclasses.', 'Understanding and Applying Abstraction with Abstract Classes/Methods', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('9e116c2d-907b-4027-abf4-1c427f5b9055', 'This KC addresses the `is-a` relationship, which conceptually models inheritance, signifying that a subclass `is a type of` its superclass. Grasping this concept is fundamental for correctly applying inheritance and designing logical class hierarchies. Learners can demonstrate understanding by accurately stating that a `Dog` `is a` `Animal` when `Dog` inherits from `Animal`, and explaining why this relationship is appropriate.', 'Explaining `Is-a` Relationships in Inheritance', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('aba7461f-882c-49dc-8007-8e14801cb4df', 'This KC involves providing the concrete code that fulfills the promises made by an interface or abstract class. It demonstrates the ability to translate an abstract design into a functional component. For instance, a learner should be able to write the code for a `Circle` class that implements the `calculateArea()` method defined in a `Shape` interface.', 'Implementing Abstract Contracts', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', 'This KC focuses on the ability to identify essential features and common functionalities, rather than getting bogged down in implementation details, when designing user interfaces. It matters because it enables the creation of flexible, scalable, and intuitive interfaces that can adapt to changing requirements. For example, a learner should be able to abstract a `data entry field` concept that can be implemented as a text box, dropdown, or slider depending on context.', 'Applying Abstraction to Interface Design', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('f0151e0a-4d88-4160-b9df-3d8eff23d352', 'Learners will understand that designing **abstract interfaces** (e.g., ''Take me to the airport'') instead of concrete ones (e.g., ''Turn right, then left'') promotes **higher reusability** in object-oriented classes. This is crucial because reusable classes are a fundamental goal of good OO design. This skill is applied by identifying general user goals and creating an interface that can be implemented in diverse, specific contexts, ensuring the interface remains consistent regardless of internal implementation changes.', 'Design Abstract Interfaces for Reusability', true, '2025-08-17 08:31:59.730742', '2025-08-17 08:31:59.730742');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('1889697c-ddf5-4397-b94f-ecad3a5e71dd', 'Learners will be able to determine the **necessary behaviours (methods)** of an object from the perspective of its identified users, leveraging tools like UML Use Cases for requirements gathering. It is important to also consider **environmental constraints** (e.g., computer hardware limits, network availability) that might limit an object''s functionality. This skill is applied by translating user needs and system limitations into observable actions and methods for a given object.', 'Determine Object Behaviors and Environmental Constraints', true, '2025-08-17 08:31:59.731142', '2025-08-17 08:31:59.731142');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'Learners will understand that identifying **all users of a class or system** (including end-customers, other interacting objects, and internal roles like a ''cabbie'' in a taxi system) is paramount for effective interface design. This ensures the creation of a realistic and usable interface that satisfies the varied requirements and constraints of all interacting parties. This skill is applied by brainstorming all potential entities that might send messages to or receive services from a class.', 'Identify All Class Users for Interface Design', true, '2025-08-17 08:31:59.730981', '2025-08-17 08:31:59.730981');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('2ed95544-8955-4b79-abda-d09f8d9499d1', 'Learners will grasp the **fundamental distinction between a class''s public interface (what it does and the services it exposes) and its internal implementation (how it achieves those services)**. This separation is crucial for fostering **modular design, abstraction, and maintainability**, as it ensures that internal implementation changes ideally do not necessitate alterations to external user code. This skill is applied by designing classes with a **minimal public interface** (exposing only essential methods) and ensuring all internal details, such as attributes and private methods, are **hidden** from users.', 'Differentiate Interface from Implementation', true, '2025-08-17 08:42:40.788064', '2025-08-17 08:42:40.788064');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('f301d039-f264-4188-b368-39bad0e05c1c', 'This KC is about recognizing the core components of a class within a UML Class Diagram, including its name, attributes, and methods, which are essential for understanding class structure. A learner can demonstrate mastery by correctly labeling these parts in a provided class diagram or by constructing a simple class diagram from a textual description.', 'Identifying Class Elements in a UML Diagram', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC focuses on understanding and applying access modifiers (e.g., `private`, `public` in Java/C++, or conventions like `_` in Python) to control the visibility of class members. It is crucial for enforcing encapsulation by restricting direct external access to an object''s internal state, ensuring data integrity. For example, declaring an attribute `private` prevents direct modification from outside the class.', 'Defining Private and Public Members', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('879a304b-b2d3-46c6-982e-e75ef475d4e2', 'This KC involves differentiating between superclasses (parent classes) and subclasses (child classes) within an inheritance hierarchy. Understanding these roles is vital for designing robust class structures and predicting object behavior. A learner should be able to identify which class is the superclass and which is the subclass in a given code snippet, for example, recognizing `Animal` as the superclass and `Dog` as the subclass when `Dog` inherits from `Animal`.', 'Distinguishing Superclasses and Subclasses', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', 'This KC addresses object composition, a design technique where one class contains instances of other classes as its members, representing a `has-a` relationship. Composition promotes code reuse and flexibility by allowing independent development and reuse of components. A learner can demonstrate this by creating a `Car` class that `has a` `Engine` object as one of its attributes, rather than inheriting from `Engine`.', 'Implementing Object Composition for `Has-a` Relationships', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('ea329450-6108-4b0b-88fb-df8609932bde', 'This KC covers the fundamental concept of functions (subroutines or procedures) in procedural programming, including their definition, parameters, return types, and invocation. It is crucial for structuring code into reusable blocks, improving readability, and managing complexity in procedural paradigms. Learners demonstrate mastery by correctly identifying function definitions and calls in code snippets or writing simple functions to perform specific tasks.', 'Identifying and Utilizing Functions in Procedural Programming', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'This KC focuses on how data is managed and manipulated in a procedural programming context, specifically addressing the use of global versus local variables and parameter passing. Understanding these concepts is essential for controlling data scope and flow within a program, preventing unintended side effects. Mastery is shown by predicting variable values at different points in a procedural program or by correctly using parameters to pass data between functions.', 'Understanding Data Handling in Procedural Programming', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', 'This KC encompasses the ability to recognize and describe the defining characteristics of procedural programming, such as sequential execution, reliance on functions, and the separation of data from the operations that act upon it. This understanding forms a foundational contrast for later learning about object-oriented programming. Learners demonstrate this by identifying procedural patterns in code or articulating the benefits and drawbacks of this paradigm in various scenarios.', 'Distinguishing Core Principles of Procedural Programming', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('e293e2c6-99a8-49c9-97d2-fd67086cdef3', 'This KC involves the ability to compare and contrast the fundamental approaches of procedural and object-oriented programming, particularly concerning data encapsulation, modularity, and problem-solving methodologies. It highlights why OOP emerged as an alternative for managing complex systems. Mastery is demonstrated by explaining how a given problem would be approached differently in each paradigm or by identifying which paradigm''s principles are being applied in a code example.', 'Contrasting Procedural and Object-Oriented Paradigms', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('803a4f07-4b9b-4428-855c-56931180ac44', 'This KC involves creating an instance of a class, known as an object, in memory. Understanding instantiation is crucial for utilizing the class blueprint to create concrete entities. A student should demonstrate this by writing `my_car = Car()` to create an object.', 'Instantiating an Object from a Class', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC covers the ability to declare a basic class in a programming language, acting as a blueprint for objects. It''s fundamental for organizing code into reusable, modular components. For example, a student should be able to write the syntax for `class Car:`.', 'Defining a Class Structure', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('f8e293fe-8bdf-44cc-9a73-412520a80e62', 'This KC focuses on adding data members (attributes or properties) to a class definition. These attributes store the state specific to each object instance. A student should be able to define attributes like `self.color = ''red''` within a class''s `__init__` method.', 'Defining Class Attributes (Object Data)', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC involves declaring functions (methods) within a class that define the behaviors or actions an object can perform. Methods encapsulate an object''s functionality. A student should be able to define a method such as `def start_engine(self):` within a class.', 'Defining Class Methods (Object Behaviors)', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('36e59beb-3737-4a17-b8b0-d240ff8fd674', 'This KC pertains to retrieving the values of attributes belonging to an object. Correctly accessing object data is essential for interacting with an object''s state. For example, a student should be able to write `print(my_car.color)` to display an object''s attribute.', 'Accessing Object Attributes', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC assesses the understanding of the conceptual distinction between a class (a blueprint) and an object (an instance of that blueprint). This foundational concept is vital for grasping object-oriented design principles. A student should be able to explain that a ''Car'' is a class, while ''my_car'' is a specific object created from that class.', 'Differentiating Classes and Objects', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('22ff0a1d-bfb4-4d88-862a-29ec02a744fa', 'This KC covers the skill of calling methods on an instantiated object to trigger its defined behaviors. Correctly invoking methods is key to making objects perform actions. A student should be able to call a method like `my_car.start_engine()` on an object.', 'Invoking Object Methods', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('ae3025ca-1a56-4f7a-975c-c19a839427bd', 'This KC focuses on the fundamental concept of objects communicating by sending messages to one another, which is crucial for building interactive object-oriented systems. It involves identifying the sender, receiver, and message content (method call) in a given scenario, assessable by explaining how an object invokes an operation on another.', 'Understanding Message Sending in OOP', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('1323bbe7-116c-4fb1-b059-b8a07e0916ca', 'This KC involves understanding and applying encapsulation by declaring class members with appropriate access modifiers (e.g., `private`, `public`) to restrict direct access to internal data. It emphasizes using public methods (getters/setters) to control how data is accessed and modified, thereby enhancing data integrity and maintainability. For example, creating a `BankAccount` class where the `balance` is private and accessible only via `deposit()` and `withdraw()` public methods.', 'Applying Encapsulation Principles', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('96207b35-90f2-4236-9886-7760d38e42ad', 'This KC focuses on identifying the key differences and appropriate use cases for interfaces versus abstract classes in object-oriented design. It involves understanding their distinct roles in achieving abstraction and polymorphism, such as interfaces defining capabilities while abstract classes provide partial implementations or common base behaviors. For example, understanding that an interface can be implemented by multiple, unrelated classes, whereas a class can only extend one abstract class.', 'Distinguishing Interfaces from Abstract Classes', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('c83bb940-8d84-4bc2-ae69-0c8757207c77', 'This KC focuses on understanding and differentiating various relationships between classes in a UML Class Diagram, such as association, aggregation, composition, and inheritance. This skill is critical for modeling complex systems and understanding object interactions. Learners can apply this by explaining the implications of a specific relationship type between two classes or by drawing the correct relationship symbol for a given design scenario.', 'Interpreting Relationships Between Classes in a UML Diagram', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', 'This KC involves creating and utilizing public methods (getters and setters) to provide controlled access to private instance variables. This is fundamental for encapsulation, allowing for validation or transformation of data before it''s set, or read-only access. A common application is a `setAge(int age)` method that validates `age` is positive before assignment.', 'Using Getters and Setters', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('97a48d3a-8282-4216-a58b-cbf75d3c7023', 'This KC explains why encapsulation is a core OOP principle, emphasizing its advantages such as data protection, reduced complexity, and enhanced modularity. By hiding internal details, it makes code easier to maintain, debug, and prevents unintended side effects. For instance, changing an internal data structure does not break external code as long as the public interface (getters/setters) remains consistent.', 'Understanding the Benefits of Encapsulation', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('ba935e44-3c0f-41f3-9467-154a61f3d4c5', 'This KC emphasizes the design principle of programming to interfaces rather than implementations, leading to systems with reduced dependencies. This paradigm promotes loose coupling, making code more modular, maintainable, and extensible, as changes in one implementation don''t necessarily affect other parts of the system. For example, a `PaymentProcessor` that interacts with a `PaymentGateway` interface rather than a specific `PayPalGateway` implementation.', 'Applying the Interface/Implementation Paradigm for Loose Coupling', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('eaa51591-8133-4516-9db3-8848b9571cd9', 'This KC explains how interfaces enable polymorphism, allowing objects of different concrete classes to be treated as objects of a common interface type. This facilitates writing generic code that can operate on various implementing classes interchangeably, enhancing flexibility and reusability. A method accepting an `Animal` interface argument can process `Dog` or `Cat` objects, each with its own `makeSound()` implementation.', 'Using Interfaces for Polymorphism', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('a3878dc5-979e-47f1-b344-e8fa69845ef6', 'This KC covers polymorphism, specifically through method overriding, where a subclass provides a specific implementation of a method that is already defined in its superclass. Polymorphism allows objects of different classes to be treated as objects of a common type, enhancing flexibility and extensibility. A learner can demonstrate mastery by overriding a `makeSound()` method in a `Dog` subclass to bark, while the `Animal` superclass`s `makeSound()` might just make a generic sound.', 'Implementing Polymorphism via Method Overriding', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('ce845442-0c3d-4de6-bbe6-765445fbfe06', 'This KC involves distinguishing between inheritance (`is-a` relationship) and composition (`has-a` relationship), and understanding when to apply each. Choosing the correct relationship is crucial for designing flexible, maintainable, and robust software systems. Learners should be able to explain that a `Dog` `is an` `Animal` (inheritance) while a `Car` `has an` `Engine` (composition), and justify the choice in different scenarios.', 'Differentiating Between Inheritance (`Is-a`) and Composition (`Has-a`)', true, '2025-08-17 08:20:51.917327', '2025-08-17 08:23:25.468331');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('7a3b6aa3-01d2-4374-896e-33fdb9b3d428', 'Learners will grasp the principle of providing the **absolute minimal user interface** for a class, exposing only what external users **absolutely need** to interact with it. This is crucial for simplifying class usage, enhancing security by controlling access to sensitive data, and preventing unnecessary coupling. It is applied by initially designing a class with minimal public methods and iteratively adding more only when explicitly required or identified through user feedback.', 'Design Minimal Public Interfaces', true, '2025-08-17 08:31:59.730742', '2025-08-17 08:31:59.730742');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('80c78721-2a0d-4a7d-aca6-28513b321eee', 'Operator overloading allows developers to redefine the meaning of standard operators (e.g., `+`, `-`) for custom data types or objects. While powerful for creating intuitive syntax, it can lead to confusing and hard-to-maintain code if not used judiciously. An example is using the `+` operator for string concatenation (e.g., `String Name = firstName + '' '' + lastName;`) instead of numeric addition. This can be tested by providing an overloaded operator usage and asking for the expected outcome.', 'Customising Operator Behaviour', true, '2025-08-17 08:46:04.600103', '2025-08-17 08:46:04.600103');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('61240d41-e0e0-4f01-8315-01c8e433eaf9', 'Constructors are special methods invoked automatically when a new object is created, primarily used to set the object to an initial, stable state. They ensure essential attributes are properly set before an object is used, preventing unstable states or errors. For example, in Java, a constructor like `public Cabbie() { name = null; myCab = null; }` sets initial values for an object. This skill can be tested by asking about their purpose or how they''re invoked.', 'Initialising Objects with Constructors', true, '2025-08-17 08:46:04.570361', '2025-08-17 08:46:04.570361');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('9b66ba2c-d515-4710-8312-336840750dc1', 'Multiple inheritance permits a class to inherit attributes and methods from more than one parent class, as seen in real-world analogies like a child having two parents. While it can solve certain problems elegantly, it significantly increases system complexity, leading languages like Java, .NET, and Swift to generally not support it in its conventional form, preferring interfaces for behavioural inheritance. Evaluate its use by considering the increased complexity versus the design problem it aims to solve. This can be assessed by asking about its advantages and disadvantages or which languages support it.', 'Evaluating Multiple Inheritance in OOP', true, '2025-08-17 08:46:04.606444', '2025-08-17 08:46:04.606444');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('caef84fa-0019-4a13-b4c2-c6c11e3f94e0', 'Constructor overloading allows a class to have multiple constructors with different parameter lists, enabling objects to be instantiated in various ways depending on available information. This provides flexibility in object creation, allowing different initialization paths based on context (e.g., creating a `Count` object with a default zero or a specified starting number). Developers apply this by defining multiple constructors with distinct signatures, letting the compiler select the appropriate one based on arguments provided during instantiation. This can be assessed by providing a scenario and asking which constructor would be called.', 'Using Multiple Object Constructors', true, '2025-08-17 08:46:04.579955', '2025-08-17 08:46:04.579955');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('c1c06c13-6f5e-49b6-a948-048f2c8bb455', 'Exceptions are unexpected events during program execution, and object-oriented languages provide mechanisms (like `try/catch/throw` blocks) to detect and handle them gracefully. Proper exception handling prevents application crashes and allows for error recovery or graceful exits, ensuring system stability. Programmers use `try` to enclose code that might throw an exception and `catch` to define blocks of code that execute when a specific exception type occurs, such as handling an `ArithmeticException` for division by zero. This skill can be tested by asking to complete a code snippet to handle a specific error.', 'Managing Runtime Errors with Exceptions', true, '2025-08-17 08:46:04.584285', '2025-08-17 08:46:04.584285');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('f65a45d6-d4d1-4f97-9959-233bf7a2f88e', 'Scope defines the accessibility and lifetime of attributes within a program, categorised as local (within a method), object (within an instance), or class (shared across all instances). Understanding scope is crucial for data integrity, preventing unintended modification, and efficient memory management. For example, a `static` attribute like `companyName` in a `Cabbie` class has class scope, meaning all `Cabbie` objects share the same value in memory. This skill can be assessed by identifying the scope of variables in code snippets or explaining the implications of changing a variable''s scope.', 'Differentiating Local, Object, and Class Scope', true, '2025-08-17 08:46:04.590257', '2025-08-17 08:46:04.590257');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', 'Copying objects is more complex than primitive types due to references; a shallow copy duplicates only the references, while a deep copy recursively duplicates all referenced objects. Choosing the correct copying mechanism ensures data independence between the original and copied objects, preventing unintended side effects when one is modified. For example, a deep copy of an object with nested objects creates entirely new instances for all levels, whereas a shallow copy results in both objects pointing to the same nested instances. This skill can be tested by describing a complex object structure and asking for the result of a deep versus shallow copy operation.', 'Performing Deep vs. Shallow Object Copies', true, '2025-08-17 08:46:04.60644', '2025-08-17 08:46:04.60644');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'This KC involves creating a concrete class that adheres to an interface''s contract by providing implementations for all its abstract methods. This process ensures the class provides specific functionalities, making it compatible with other components designed to interact with that interface. For instance, a `Circle` class implements `Shape` by providing its own concrete `calculateArea()` method.', 'Implementing an Interface', true, '2025-08-17 09:00:30.620831', '2025-08-17 09:00:30.620831');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', 'This KC assesses the ability to pinpoint the parts of a codebase that represent the interface versus those that represent the implementation. It is essential for reading and understanding existing code and making informed design decisions. A learner should be able to distinguish between a method signature (interface) and its method body (implementation) in a given code snippet.', 'Recognizing Interface Elements in Code', true, '2025-08-17 09:00:30.626469', '2025-08-17 09:00:30.626469');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC covers the syntax and purpose of defining an interface, which acts as a contract specifying a set of abstract methods that a class must implement. Interfaces establish a blueprint for behavior without providing implementation details, promoting abstraction and standardizing functionality across different classes. An example is defining `interface Shape { double calculateArea(); }`.', 'Defining an Interface', true, '2025-08-17 09:00:30.625897', '2025-08-17 09:00:30.625897');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('9fbe5a80-4649-445d-8bf2-a4c4795d8571', 'Understanding how to name classes effectively ensures clarity, identification, and adherence to language-specific requirements. Class names should be descriptive of what the class does and, in languages like Java, must match the filename for compilation. This is applied by selecting names that clearly communicate the class''s purpose and following established coding standards.', 'Applying Class Naming Conventions', true, '2025-08-17 09:00:30.638059', '2025-08-17 09:00:30.638059');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('1db3b49c-dfef-4855-94df-45b59047fa25', 'This KC involves assessing the quality of a software design based on how well it separates interfaces from their implementations. This analytical skill is vital for building robust, scalable, and testable systems. A learner should be able to identify good practices (e.g., programming to an interface) and bad practices (e.g., tightly coupled code) in a given code example.', 'Evaluating Interface-Implementation Design', true, '2025-08-17 09:00:30.645824', '2025-08-17 09:00:30.645824');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('7517905d-9f0b-4eeb-8e80-2718ebfb5a72', 'Writing appropriate comments is crucial for understanding a class''s function, its internal logic, and facilitating maintenance. Comments help to clarify the purpose and behaviour of classes and their components. This involves using C-style (`/* */`) for multi-line comments and single-line (`//`) comments, understanding their syntax to prevent code from being inadvertently ignored by the compiler.', 'Documenting Classes with Comments', true, '2025-08-17 09:00:30.662304', '2025-08-17 09:00:30.662304');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'Attributes define the state of an object, storing essential information about it. Declaring attributes involves choosing appropriate access modifiers: ''private'' restricts direct external access, aligning with the principle of keeping the interface minimal. ''Static'' attributes create a single shared copy across all objects of the class, affecting memory allocation and shared state. This is applied by defining attributes to hold an object''s state while controlling their visibility and shared nature for data integrity.', 'Declaring and Understanding Class Attributes', true, '2025-08-17 09:00:30.667719', '2025-08-17 09:00:30.667719');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('7bd074f2-04d0-462c-8d0d-a53ac985e077', 'Public interface methods define the services a class offers to other objects, representing its external application programming interface (API). These methods should be abstract, providing the functionality users need without exposing internal implementation details. The goal is to provide the absolute minimal user interface possible, ensuring conciseness and avoiding unnecessary exposure of behaviours. This is applied by defining public methods that allow interaction with the class, ensuring minimal exposure of internal workings and adherence to design principles.', 'Designing Public Class Interfaces', true, '2025-08-17 09:00:30.675753', '2025-08-17 09:00:30.675753');
INSERT INTO public.knowledge_components (kc_id, description, kc_name, is_active, created_at, updated_at) VALUES ('4d11f382-1287-4e52-b80f-d2dc1e655725', 'Private methods encapsulate internal logic and helper functions that are not intended for direct access by other classes. They are strictly part of the class''s internal implementation, hidden from the public interface. This is applied by defining private methods (e.g., `turnRight()`, `turnLeft()`) that are called internally by the class''s public methods to perform specific, encapsulated tasks, ensuring that the user only interacts with the public interface.', 'Implementing Private Class Methods', true, '2025-08-17 09:00:30.680481', '2025-08-17 09:00:30.680481');


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('ff7627f7-e36a-4c23-abce-bf5bc95087db', 'Welcome to our lesson on **Interface vs. Implementation**, a cornerstone concept in object-oriented design. Mastering this distinction is crucial for crafting software that is **modular, abstract, and highly maintainable**. It helps ensure that changes made to the internal workings of a class do not force alterations in the code that uses that class.

## Differentiate Interface from Implementation

At its heart, the difference between an interface and an implementation lies in **what a class does** versus **how it does it**. Think of an object as a ''black box''. You interact with it through its defined public services (the interface), without needing to know the intricate details of its internal machinery (the implementation).

### What is the Interface?

The **interface** of a class defines the **set of services it offers to other objects**. It''s the public face of your class, essentially its external Application Programming Interface (API). When designing an interface, the goal is to provide the **absolute minimal user interface possible**. This means exposing only what external users (other developers or objects) absolutely need to interact with the class.

For instance, if you''re using a toaster, your interface to it includes plugging it into an electrical outlet and pressing the toast button. You don''t need to understand the complex internal wiring or heating elements to use it effectively. Similarly, in a car, the steering wheel, pedals, and gearstick are part of the interface you interact with.

```mermaid
graph TD
    A[User/Client Code] --> |Requests Service| B["Class Interface(Public Methods)"]
    B --> |Invokes| C["Internal Implementation(Hidden Details)"]
    C --> |Returns Result| B
    B --> |Provides Result| A
```

### What is the Implementation?

The **implementation** comprises all the **internal details** of how a class achieves its defined services. These details should be **hidden** from users. This includes private attributes (data) and private methods (helper functions). The goal is to design classes such that a **change to their internal implementation does not require a change to the user''s code**.

Continuing the car analogy, the engine, transmission, and braking system represent the implementation. As a driver, you don''t need to know how these components work internally, only how to interact with the steering wheel and pedals. A car manufacturer can change the engine design (implementation) without requiring you to relearn how to drive (interface), as long as the external performance (what the interface delivers) remains consistent.

## Recognizing Interface Elements in Code

In code, the distinction between interface and implementation is primarily managed through **access modifiers** (like `public` and `private`) and the structure of methods.

*   **Public members** (methods) form the **interface**. Their signatures (name, parameters, return type) are what external code interacts with.
*   **Private members** (attributes and methods) belong to the **implementation**. They encapsulate internal logic and data, not intended for direct external access.

Let''s look at a `BankAccount` class. Its public methods define its interface, while its private data and internal helper methods constitute its implementation:

```java
public class BankAccount {
    // --- Implementation Details (Private) ---
    private double balance; // Private attribute: part of implementation
    private String accountNumber;

    // Private helper method: part of internal logic
    private void logTransaction(String type, double amount) {
        System.out.println("Internal Log: " + type + " of " + amount + " on account " + this.accountNumber);
    }

    // --- Interface (Public Methods) ---
    // Constructor: often part of the public interface for object creation
    public BankAccount(String accountNumber, double initialBalance) { // Method signature: public interface
        this.accountNumber = accountNumber;
        this.balance = initialBalance;
        logTransaction("Account Created", initialBalance); // Internal call to private method
    }

    // Deposit method: part of the public interface (mutator)
    public void deposit(double amount) { // Method signature: public interface
        if (amount > 0) {
            this.balance += amount;
            logTransaction("Deposit", amount); // Internal call
        } else {
            System.out.println("Deposit amount must be positive.");
        }
    } // Method body: implementation details [1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827]

    // Withdraw method: part of the public interface (mutator)
    public void withdraw(double amount) {
        if (amount > 0 && this.balance >= amount) {
            this.balance -= amount;
            logTransaction("Withdrawal", amount); // Internal call
        } else {
            System.out.println("Invalid withdrawal.");
        }
    }

    // GetBalance method: part of the public interface (accessor/getter)
    public double getBalance() { // Method signature: public interface
        return this.balance;
    } // Method body: implementation details [1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827]
}
```

In this example, `balance` and `accountNumber` are internal data, and `logTransaction` is an internal helper function. Users of the `BankAccount` class interact only with `deposit()`, `withdraw()`, and `getBalance()`, which are its public interface methods. The methods themselves contain the ''how'' (implementation), but the user only cares about the ''what'' (interface).

## Evaluating Interface-Implementation Design

Assessing the quality of software design heavily relies on how well this separation is achieved. A good design strives for **loose coupling**, meaning that classes have minimal dependencies on each other''s internal details. This is achieved by programming to interfaces rather than direct implementations.

### Good Practices:

*   **Minimal Public Interface**: Only expose what is absolutely necessary. This simplifies class usage, enhances security by controlling access to sensitive data, and prevents unnecessary coupling.
*   **Data Hiding**: All attributes should generally be declared `private`. Access to these attributes should be controlled through public accessor (getter) and mutator (setter) methods. These methods can also include validation logic, ensuring data integrity.
*   **Hide Implementation Details**: Internal methods and complex logic should be private. This allows the internal workings to change without impacting external code. The class should be **open for extension but closed for modification** (Open/Closed Principle).

### Bad Practices (and how to avoid them):

*   **Exposing Internal Data (Public Attributes)**: Declaring attributes `public` breaks data hiding and allows uncontrolled manipulation, making debugging and maintenance difficult.
*   **Tight Coupling**: When classes are overly dependent on each other''s implementation details, changes in one class can necessitate changes throughout the system. This can lead to **rigid, fragile, and non-reusable code**. Designing with a minimal public interface and focusing on **abstraction** helps prevent this.

Consider a `DataBaseReader` class. If its public interface remains consistent, the underlying database technology (Oracle, SQLAnywhere, etc.) can change without forcing the user''s application code to be recompiled. This demonstrates the power of a well-designed interface that hides implementation details. The user only needs to know *what* methods to call, not *how* those methods access the specific database.

By consistently applying these principles, you build robust, scalable, and testable systems.', 'Interface vs. Implementation', 'This lesson explains Interface vs. Implementation in object-oriented design. The interface defines what a class does—its public methods and services—while the implementation defines how it achieves them—its private data and internal logic. Proper separation ensures modular, maintainable, and loosely coupled code, allowing internal changes without affecting external usage. Examples include `BankAccount` methods as interface and private attributes as implementation.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('41c441dd-1cf1-41b8-a1a3-d182683f78fa', 'Welcome to this lesson, where we''ll explore three crucial concepts in object-oriented programming: **scope**, **object copying (deep vs. shallow)**, and **customising operator behaviour (operator overloading)**. Mastering these will give you a deeper understanding of how data is managed, accessed, and manipulated within your programs, leading to more robust and maintainable code.

## Differentiating Local, Object, and Class Scope

**Scope** defines the **accessibility and lifetime of attributes** (variables) within a program. Understanding scope is fundamental for ensuring data integrity, preventing unintended modifications, and managing memory efficiently. In Java, scope is primarily delineated by curly braces `{}`. There are three main categories of attribute scope:

### 1. Local Attributes (Method Scope)

**Local attributes** are variables declared **inside a specific method** or block of code. Their accessibility and lifetime are limited to that method or block. Once the method finishes execution, the copy of the local attribute is removed from memory. This means one method has no knowledge of local variables declared in another, even if they share the same name within different methods.

Consider this Java example:

```java
public class Number {

    public void method1() {
        int count; // Local attribute, accessible only within method1
        count = 10;
        System.out.println("Inside method1, count: " + count);
    }

    public void method2() {
        int count; // Different local attribute, accessible only within method2
        count = 20;
        System.out.println("Inside method2, count: " + count);
        // Cannot access count from method1 here
    }

    public static void main(String[] args) {
        Number num = new Number();
        num.method1();
        num.method2();
    }
}
```

### 2. Object Attributes (Instance Scope)

**Object attributes**, also known as **instance variables**, are declared **within a class but outside any method**. Each **object (instance)** instantiated from the class gets its **own separate copy** of these attributes. This means that if you have multiple objects of the same class, a change to an object attribute in one instance will not affect the same attribute in another instance. These attributes are accessible by all methods within that specific object.

The `this` keyword can be used to explicitly refer to the current object''s attributes, differentiating them from local variables if they share the same name.

```java
public class MyCar {
    String color; // Object attribute, each MyCar object has its own color

    public MyCar(String color) {
        this.color = color; // ''this.color'' refers to the object attribute
    }

    public void displayColor() {
        System.out.println("My car''s color is: " + color);
    }

    public static void main(String[] args) {
        MyCar car1 = new MyCar("Red");
        MyCar car2 = new MyCar("Blue");

        car1.displayColor(); // Output: My car''s color is: Red
        car2.displayColor(); // Output: My car''s color is: Blue
    }
}
```

### 3. Class Attributes (Static Scope)

**Class attributes**, declared with the `static` keyword, have a **single shared copy across all objects** of the same class. This means that all instances of a class will use the same memory location for that attribute. Changes made to a static attribute by one object will be visible to all other objects of that class. This is the closest you get to "global data" in object-oriented design. While useful in specific scenarios, they require careful handling due to potential **synchronisation problems**.

```java
public class Company {
    static String companyName = "Global Tech Inc."; // Class attribute, shared by all Company objects
    String employeeName; // Object attribute

    public Company(String employeeName) {
        this.employeeName = employeeName;
    }

    public void displayInfo() {
        System.out.println(employeeName + " works for " + companyName);
    }

    public static void changeCompanyName(String newName) {
        companyName = newName;
        System.out.println("Company name changed to: " + companyName);
    }

    public static void main(String[] args) {
        Company emp1 = new Company("Alice");
        Company emp2 = new Company("Bob");

        emp1.displayInfo(); // Output: Alice works for Global Tech Inc.
        emp2.displayInfo(); // Output: Bob works for Global Tech Inc.

        Company.changeCompanyName("Worldwide Solutions"); // Changes the static attribute

        emp1.displayInfo(); // Output: Alice works for Worldwide Solutions
        emp2.displayInfo(); // Output: Bob works for Worldwide Solutions
    }
}
```

```mermaid
graph TD
    A[Program Memory] --> B{Class Definition}
    B --> C{Static Attributes}
    C -- Shared Access --> D1[Object 1]
    C -- Shared Access --> D2[Object 2]
    C -- Shared Access --> D3[Object 3]
    D1 --> E1[Object Attributes of Object 1]
    D2 --> E2[Object Attributes of Object 2]
    D3 --> E3[Object Attributes of Object 3]
    D1 --> F1[Method Calls on Object 1]
    F1 --> G1[Local Attributes in Method 1]
    F1 --> G2[Local Attributes in Method 2]
    style C fill:#f9f,stroke:#333,stroke-width:2px
    style E1 fill:#f9f,stroke:#333,stroke-width:2px
    style E2 fill:#f9f,stroke:#333,stroke-width:2px
    style E3 fill:#f9f,stroke:#333,stroke-width:2px
    style G1 fill:#9cf,stroke:#333,stroke-width:2px
    style G2 fill:#9cf,stroke:#333,stroke-width:2px
    linkStyle 0,1,2,3,4,5 stroke:#333,stroke-width:1px,fill:none;
    linkStyle 6,7,8 stroke:#f00,stroke-width:2px,fill:none;
```

## Performing Deep vs. Shallow Object Copies

Copying objects is more intricate than copying primitive data types because objects can contain **references to other objects**. This complexity gives rise to two primary types of object copies: **shallow copies** and **deep copies**. Choosing the correct copying mechanism is vital for ensuring **data independence** and preventing unintended side effects when one object is modified.

### Shallow Copy

A **shallow copy** duplicates only the **references** to the objects, not the objects themselves. This means that both the original and the copied object will point to (reference) the **same nested objects**. If you modify a nested object through one reference, the change will be visible through the other reference as well, as they both refer to the identical underlying data. This can lead to unexpected side effects.

```java
class Address {
    String street;
    String city;

    public Address(String street, String city) {
        this.street = street;
        this.city = city;
    }

    @Override
    public String toString() {
        return street + ", " + city;
    }
}

class Person implements Cloneable { // Implements Cloneable for shallow copy example
    String name;
    Address address;

    public Person(String name, Address address) {
        this.name = name;
        this.address = address;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone(); // Performs a shallow copy
    }

    public static void main(String[] args) throws CloneNotSupportedException {
        Address originalAddress = new Address("123 Main St", "Anytown");
        Person originalPerson = new Person("Alice", originalAddress);

        // Shallow copy
        Person copiedPerson = (Person) originalPerson.clone();

        System.out.println("Original Person: " + originalPerson.name + " at " + originalPerson.address);
        System.out.println("Copied Person: " + copiedPerson.name + " at " + copiedPerson.address);

        // Modify the address through the copied person
        copiedPerson.address.street = "456 Oak Ave";
        copiedPerson.address.city = "Somewhere";

        System.out.println("\nAfter modifying copiedPerson''s address:");
        System.out.println("Original Person: " + originalPerson.name + " at " + originalPerson.address); // Original also changes!
        System.println("Copied Person: " + copiedPerson.name + " at " + copiedPerson.address);
    }
}
```

```mermaid
graph TD
    A[Original Object] --> B{Reference to Nested Object}
    C[Shallow Copied Object] --> B
    B -- Changes propagate --> D[Actual Nested Object Data]
    style B fill:#f9f,stroke:#333,stroke-width:2px
    linkStyle 0,1 stroke:#f00,stroke-width:2px,fill:none;
    linkStyle 2 stroke:#333,stroke-width:1px,fill:none;
```

### Deep Copy

A **deep copy** recursively duplicates all referenced objects, creating **entirely new instances for all levels** of nested objects. This ensures that the original and copied objects are completely independent, preventing unintended side effects when one is modified. Deep copies can involve significant overhead, especially for complex object structures with many levels of references.

```java
class Address implements Cloneable {
    String street;
    String city;

    public Address(String street, String city) {
        this.street = street;
        this.city = city;
    }

    @Override
    public String toString() {
        return street + ", " + city;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        // For Address, a shallow copy is a deep copy since it has no nested reference types
        return super.clone();
    }
}

class Person implements Cloneable {
    String name;
    Address address; // Reference to an Address object

    public Person(String name, Address address) {
        this.name = name;
        this.address = address;
    }

    // Method to perform a deep copy
    public Person deepCopy() throws CloneNotSupportedException {
        Person clonedPerson = (Person) super.clone(); // Shallow copy first
        clonedPerson.address = (Address) this.address.clone(); // Deep copy the nested Address object
        return clonedPerson;
    }

    public static void main(String[] args) throws CloneNotSupportedException {
        Address originalAddress = new Address("123 Main St", "Anytown");
        Person originalPerson = new Person("Alice", originalAddress);

        // Deep copy
        Person copiedPerson = originalPerson.deepCopy();

        System.out.println("Original Person: " + originalPerson.name + " at " + originalPerson.address);
        System.out.println("Copied Person: " + copiedPerson.name + " at " + copiedPerson.address);

        // Modify the address through the copied person
        copiedPerson.address.street = "456 Oak Ave";
        copiedPerson.address.city = "Somewhere";

        System.out.println("\nAfter modifying copiedPerson''s address:");
        System.out.println("Original Person: " + originalPerson.name + " at " + originalPerson.address); // Original remains unchanged
        System.out.println("Copied Person: " + copiedPerson.name + " at " + copiedPerson.address);
    }
}
```

```mermaid
graph TD
    A[Original Object] --> B{Reference to Nested Object A}
    C[Deep Copied Object] --> D{Reference to Nested Object B}
    B -- points to --> E["Actual Nested Object Data (Original)"]
    D -- points to --> F["Actual Nested Object Data (Copy)"]
    style B fill:#f9f,stroke:#333,stroke-width:2px
    style D fill:#f9f,stroke:#333,stroke-width:2px
    style E fill:#9cf,stroke:#333,stroke-width:2px
    style F fill:#9cf,stroke:#333,stroke-width:2px
    linkStyle 0,1,2,3 stroke:#333,stroke-width:1px,fill:none;
```

## Customising Operator Behaviour (Operator Overloading)

**Operator overloading** allows developers to **redefine the meaning of standard operators** (like `+`, `-`, `*`, `/`) for custom data types or objects. This can be a powerful feature for creating more intuitive and readable syntax when working with your own classes.

For instance, the `+` operator commonly signifies numeric addition, but in Java, it is **overloaded to perform string concatenation**.

```java
public class OperatorExample {
    public static void main(String[] args) {
        // Numeric addition
        int sum = 5 + 6;
        System.out.println("5 + 6 = " + sum); // Output: 5 + 6 = 11

        // String concatenation (operator overloading in action)
        String firstName = "Joe";
        String lastName = "Smith";
        String fullName = firstName + " " + lastName; // ''+'' is overloaded for strings
        System.out.println("Full Name: " + fullName); // Output: Full Name: Joe Smith
    }
}
```

While powerful for customising operator behaviour to fit domain-specific operations (e.g., adding two `Matrix` objects as `Matrix C = A + B;`), operator overloading can lead to **confusing and hard-to-maintain code if not used judiciously**. Redefining an operator in an unintuitive way (e.g., making `+` perform subtraction) would severely hamper code readability and increase debugging difficulty.

Most modern object-oriented languages, including Java, **do not allow direct operator overloading** for user-defined types to prevent such pitfalls, relying instead on methods for custom operations. However, the *concept* of an operator behaving differently based on context (like the `+` operator for strings) is still a form of overloading.

**Key considerations for customising operator behaviour (or implementing similar functionality via methods):**

*   **Intuition:** Ensure the redefined operator''s behaviour is intuitive and aligns with common mathematical or logical expectations.
*   **Readability:** Overloading should enhance, not detract from, code readability.
*   **Documentation:** Always **clearly document** any custom operator behaviour to aid maintainers and prevent confusion.

By understanding these concepts, you can write cleaner, more efficient, and more understandable object-oriented programs.', 'Understanding Scope, Object Copying, and Custom Operators', 'This lesson explains scope, object copying, and operator overloading in OOP. Scope determines where variables are accessible: local (method), object (instance), or class (static). Shallow vs. deep copies control whether objects share nested references or have independent copies. Operator overloading lets operators like `+` behave differently for custom types, enhancing expressiveness but requiring careful, intuitive use to maintain readability and correctness.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('3de328c4-0659-43e9-b5e8-7882f6b02878', '## Interfaces: Enabling Flexible and Decoupled Designs

In Object-Oriented Programming (OOP), **interfaces are a cornerstone for building flexible, reusable, and maintainable software systems**. They go beyond simply defining a contract for behaviour, as discussed previously, by enabling two crucial design principles: **polymorphism** and **loose coupling**. These principles allow your code to adapt to change gracefully, interact seamlessly with various components, and minimise the impact of internal implementation alterations.

### Using Interfaces for Polymorphism

**Polymorphism**, a term derived from Greek meaning "many shapes", is one of the most powerful advantages of object-oriented technologies. It allows **objects of different concrete classes to be treated as objects of a common interface type**, enabling generic code that can operate on various implementing classes interchangeably. Interfaces are a key mechanism for achieving this.

An interface defines a common set of methods (a contract) that multiple, potentially unrelated, classes can agree to implement. When you design your code to interact with this interface, rather than a specific concrete class, you achieve polymorphism. The actual behaviour that takes place depends on the type of the object implementing the interface, even though you''re calling the same method on a common interface type.

Consider our familiar `Shape` example. We can define a `Shape` interface with a `draw()` method.

```java
public interface Shape {
    void draw(); // Defines the contract: any Shape must be able to draw itself
}
```

Now, we can create various concrete classes like `Circle` and `Rectangle`, both implementing the `Shape` interface and providing their unique `draw()` implementations.

```java
public class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("I am drawing a Circle");
    }
}

public class Rectangle implements Shape {
    @Override
    public void draw() {
        System.out.println("I am drawing a Rectangle");
    }
}
```

With this setup, you can write a method that accepts a `Shape` interface, and it will work with any object that implements `Shape`, regardless of its specific class.

```java
public class DrawingApplication {
    public static void renderShape(Shape s) {
        // We don''t care if ''s'' is a Circle, Rectangle, or any other Shape.
        // The interface guarantees it has a draw() method.
        s.draw();
    }

    public static void main(String[] args) {
        Shape myCircle = new Circle();
        Shape myRectangle = new Rectangle();

        renderShape(myCircle);    // Calls Circle''s draw()
        renderShape(myRectangle); // Calls Rectangle''s draw()
    }
}
```

**This enables flexibility and reusability**: if you later add a `Triangle` class that implements `Shape`, the `renderShape` method doesn''t need to be modified; it will automatically work with `Triangle` objects too. The generic code operates on different concrete classes because they all adhere to the `Shape` contract.

### Applying the Interface/Implementation Paradigm for Loose Coupling

**Loose coupling** is a fundamental goal in good object-oriented design. It means that **classes or components have minimal dependencies on each other**, allowing them to be developed, tested, and maintained independently. When one part of the system changes, loosely coupled systems limit the ripple effect of those changes to other parts.

The principle of **"programming to an interface, not an implementation"** is central to achieving loose coupling. Instead of having a class directly depend on a specific concrete implementation, it should depend on an abstract interface that defines the required behaviour.

Imagine a `PaymentProcessor` class that needs to integrate with various payment gateways (e.g., PayPal, Stripe, Square). If `PaymentProcessor` directly depends on `PayPalGateway`, it would look like this:

```java
// Tightly coupled example (AVOID THIS for loose coupling)
public class PaymentProcessor {
    private PayPalGateway payPalGateway; // Direct dependency on a concrete implementation

    public PaymentProcessor() {
        this.payPalGateway = new PayPalGateway(); // Creates a specific implementation
    }

    public void processPayment(double amount) {
        payPalGateway.charge(amount);
    }
}

public class PayPalGateway {
    public void charge(double amount) {
        System.out.println("Processing PayPal payment: £" + amount);
    }
}
```

In this scenario, if you decide to switch from PayPal to Stripe, you would have to modify the `PaymentProcessor` class, potentially breaking it or requiring significant refactoring. This creates a **tight coupling** between `PaymentProcessor` and `PayPalGateway`.

To achieve loose coupling, we define an interface, say `PaymentGateway`, that acts as a contract for any payment processing service.

```java
// This KC emphasizes programming to interfaces for reduced dependencies.
public interface PaymentGateway {
    void processTransaction(double amount); // Defines the common payment operation
}
```

Now, `PayPalGateway` (and any future payment gateways) will implement this interface:

```java
public class PayPalGateway implements PaymentGateway {
    @Override
    public void processTransaction(double amount) {
        System.out.println("Processing PayPal payment: £" + amount);
    }
}

public class StripeGateway implements PaymentGateway {
    @Override
    public void processTransaction(double amount) {
        System.out.println("Processing Stripe payment: £" + amount);
    }
}
```

The `PaymentProcessor` then depends solely on the `PaymentGateway` interface, not a specific implementation. The concrete implementation is "injected" or provided from outside the class (e.g., via a constructor or setter, a concept related to Dependency Injection which was discussed in a prior lesson).

```java
public class PaymentProcessor {
    private PaymentGateway gateway; // Dependency on the interface

    // The specific implementation is injected via the constructor
    public PaymentProcessor(PaymentGateway gateway) {
        this.gateway = gateway;
    }

    public void makePayment(double amount) {
        gateway.processTransaction(amount);
    }
}
```

Here''s how this looks in practice:

```java
public class FinancialApplication {
    public static void main(String[] args) {
        // Use PayPal
        PaymentGateway payPal = new PayPalGateway();
        PaymentProcessor processor1 = new PaymentProcessor(payPal);
        processor1.makePayment(100.50);

        // Switch to Stripe without changing PaymentProcessor
        PaymentGateway stripe = new StripeGateway();
        PaymentProcessor processor2 = new PaymentProcessor(stripe);
        processor2.makePayment(250.00);
    }
}
```

This design significantly **reduces dependencies**. The `PaymentProcessor` class is unaware of the specific `PayPalGateway` or `StripeGateway` details; it only knows how to interact with the `PaymentGateway` contract. This means you can **change the underlying payment gateway implementation without modifying the `PaymentProcessor` class**, making your system **more modular, maintainable, and extensible**.

Here''s a visual representation of how this loose coupling works:

```mermaid
graph TD
    Client[FinancialApplication] --> PaymentProcessor
    PaymentProcessor --> PaymentGateway["«interface» PaymentGateway"]
    PaymentGateway -- "implements" --> PayPalGateway[PayPalGateway]
    PaymentGateway -- "implements" --> StripeGateway[StripeGateway]

    style PaymentGateway fill:#f9f,stroke:#333,stroke-width:2px,stroke-dasharray: 5 5
    style Client fill:#fff,stroke:#333
    style PaymentProcessor fill:#fff,stroke:#333
    style PayPalGateway fill:#ccf,stroke:#333
    style StripeGateway fill:#ccf,stroke:#333

    subgraph "Loose Coupling: Client depends on Interface, not Implementation"
        PaymentProcessor
    end
```

By consistently applying interfaces for both polymorphism and loose coupling, you build robust object-oriented systems that are adaptable to evolving requirements and easier to manage over their lifecycle.', 'Interfaces for Polymorphism and Loose Coupling', 'This lesson explains how interfaces enable polymorphism and loose coupling in OOP: they let different classes be used interchangeably through a common contract and allow code to depend on abstractions rather than specific implementations, making software more flexible, reusable, and maintainable.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('431920e5-a5df-4a0f-abf2-8d8dd6a22ea9', '## Designing Flexible Interfaces Through Abstraction

When we build software, especially user interfaces, it''s easy to get caught up in the nitty-gritty details of how everything looks and behaves at a concrete level. However, a key principle of good object-oriented design is **abstraction**, which involves focusing on the **essential features** and **common functionalities** of a component, while **hiding away the complex implementation details**. This approach is crucial for creating robust, scalable, and intuitive systems that can easily adapt to evolving requirements.

### What is Abstraction in Interface Design?

At its core, abstraction in interface design means defining *what* a component does, rather than *how* it does it. Think of it as creating a contract or a blueprint. When designing a user interface, you identify the core purpose and observable behaviours of a UI element, regardless of its specific visual representation or underlying mechanics. This ensures that changes to the internal workings of an element don''t force changes to the code that interacts with it.

For example, when you use a calculator, you interact with its public interface – the keypad and display. You press a button for ''addition'' and see a result. You don''t need to know the complex electronic or algorithmic implementation details behind that ''addition'' operation. This separation of interface from implementation is the essence of abstraction.

### Why Abstraction is Indispensable for User Interfaces

Applying abstraction to interface design yields several significant benefits:

*   **Flexibility and Adaptability**: By abstracting common behaviours, your system becomes more flexible. If you need to change how a UI element functions internally (e.g., swapping a text input for a dropdown), the external code interacting with that element remains largely unaffected, as long as the abstract interface remains consistent. This allows your application to **adapt to changing requirements** gracefully.

*   **Scalability**: A well-abstracted interface can accommodate new implementations without necessitating changes to existing code. This means you can add new variations of a UI component as your system grows, making your codebase more scalable.

*   **Reusability**: Designing abstract interfaces promotes **higher reusability** of your classes. If a common behaviour is defined abstractly, different parts of your application, or even entirely different applications, can reuse that interface, implementing it in ways specific to their context.

*   **Intuitiveness**: A minimal, abstract public interface simplifies how users (other developers or even end-users) interact with your class. By exposing only what is absolutely necessary, you make the class easier to understand and use, reducing complexity and potential errors.

### Case Study: The "Data Entry Field" Concept

Let''s consider a common UI component: a **data entry field**. From a user''s perspective, a data entry field is where they input information. However, the *way* they input that information can vary wildly. It could be a simple text box, a dropdown menu for predefined options, or even a slider for a range of values.

Without abstraction, you might create separate classes for `TextBoxField`, `DropdownField`, and `SliderField`. Any code that needs to interact with these fields would have to know the specific type of field and its unique methods. This leads to **tightly coupled code** and makes your system rigid and fragile.

Instead, we can define an **abstract interface** called `DataEntryField` (or `IDataEntryField` following common naming conventions for interfaces) that captures the essential behaviours common to all data entry fields, such as getting and setting the value.

Here''s how we might define such an interface in Java:

```java
public interface IDataEntryField {
    String getLabel(); // Get the label for the field
    void setValue(String value); // Set the value of the field
    String getValue(); // Get the current value of the field
    boolean isValid(); // Validate the input
}
```

Now, let''s create concrete implementations for a `TextField` and a `DropdownField` that adhere to this interface:

```java
public class TextField implements IDataEntryField {
    private String label;
    private String value;

    public TextField(String label) {
        this.label = label;
        this.value = "";
    }

    @Override
    public String getLabel() {
        return label;
    }

    @Override
    public void setValue(String value) {
        this.value = value; // In a real app, might add validation here
    }

    @Override
    public String getValue() {
        return value;
    }

    @Override
    public boolean isValid() {
        return !value.trim().isEmpty(); // Simple validation: not empty
    }
}
```

```java
import java.util.List;
import java.util.Arrays;

public class DropdownField implements IDataEntryField {
    private String label;
    private String selectedValue;
    private List<String> options;

    public DropdownField(String label, String... options) {
        this.label = label;
        this.options = Arrays.asList(options);
        this.selectedValue = options.length > 0 ? options : "";
    }

    @Override
    public String getLabel() {
        return label;
    }

    @Override
    public void setValue(String value) {
        if (options.contains(value)) {
            this.selectedValue = value;
        } else {
            System.out.println("Invalid option: " + value + " for dropdown " + label);
        }
    }

    @Override
    public String getValue() {
        return selectedValue;
    }

    @Override
    public boolean isValid() {
        return options.contains(selectedValue) && !selectedValue.isEmpty();
    }
    
    public List<String> getOptions() {
        return options;
    }
}
```

With these implementations, any part of our application that needs to interact with a data entry field can do so through the `IDataEntryField` interface, **without needing to know the specific type** of field it is. This is a powerful demonstration of **polymorphism** enabled by interfaces.

Consider how a form processor might handle these fields:

```java
public class FormProcessor {
    public void processField(IDataEntryField field) {
        System.out.println("Processing field: " + field.getLabel());
        if (field.isValid()) {
            System.out.println("Value: " + field.getValue() + " (Valid)");
        } else {
            System.out.println("Value: " + field.getValue() + " (Invalid)");
        }
    }

    public static void main(String[] args) {
        FormProcessor processor = new FormProcessor();

        TextField nameField = new TextField("Name");
        nameField.setValue("Alice");
        processor.processField(nameField);

        DropdownField countryField = new DropdownField("Country", "USA", "Canada", "Mexico");
        countryField.setValue("Canada");
        processor.processField(countryField);

        TextField emptyField = new TextField("Email");
        processor.processField(emptyField); // Will show invalid

        // Imagine a SliderField could also be processed here seamlessly
    }
}
```

Notice how the `FormProcessor` interacts with `IDataEntryField`. It doesn''t care if it''s a `TextField` or a `DropdownField`; it just calls the methods defined by the `IDataEntryField` interface. This is the beauty of abstraction in interface design.

### Visualizing the Abstraction

We can illustrate this with a UML diagram, showing the `IDataEntryField` interface and its concrete implementations:

```mermaid
classDiagram
    direction LR
    class IDataEntryField {
        <<interface>>
        +getLabel(): String
        +setValue(value: String): void
        +getValue(): String
        +isValid(): boolean
    }

    class TextField {
        -label: String
        -value: String
        +TextField(label: String)
        +getLabel(): String
        +setValue(value: String): void
        +getValue(): String
        +isValid(): boolean
    }

    class DropdownField {
        -label: String
        -selectedValue: String
        -options: List<String>
        +DropdownField(label: String, options: String...)
        +getLabel(): String
        +setValue(value: String): void
        +getValue(): String
        +isValid(): boolean
        +getOptions(): List<String>
    }

    IDataEntryField <|.. TextField : implements
    IDataEntryField <|.. DropdownField : implements

    class FormProcessor {
        +processField(field: IDataEntryField): void
    }

    FormProcessor --> IDataEntryField : uses
```

This diagram clearly shows how `TextField` and `DropdownField` both implement the `IDataEntryField` contract. The `FormProcessor` then depends only on this abstract interface, not on the concrete implementations. This design ensures that if a new type of `DataEntryField` (like a `SliderField`) is introduced, the `FormProcessor` code does not need to change, as long as the new field implements `IDataEntryField`.

By diligently applying abstraction to interface design, we create software that is not only functional but also elegantly structured, easy to maintain, and ready for future changes.', 'Applying Abstraction to Interface Design', 'This lesson is about Abstraction in Interface Design. It explains how to define what a component does (its essential behaviors) without exposing how it works internally, enabling flexible, reusable, and maintainable software where code can interact with abstract interfaces rather than concrete implementations.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('9a4f0331-fe2f-4689-826d-4fd87dc34225', 'Welcome to this lesson on **Controlled Data Access with Accessors**. In object-oriented programming, a fundamental principle is to manage how data within your classes is accessed and modified by other parts of your program. This ensures **data integrity, enhances security, and simplifies maintenance**.

## Defining Private and Public Members

The core of controlled data access lies in understanding **access modifiers**. These keywords dictate the visibility of your class members (attributes and methods) to other objects. The two most crucial access modifiers are `private` and `public`.

*   **`private` Members**: When an attribute or method is declared `private`, it means that it can **only be accessed from within the declaring object itself**. This strict restriction is vital for **enforcing encapsulation** and achieving **data hiding**. Imagine a car''s internal engine components; you don''t need to directly manipulate them to drive the car. Similarly, a class''s internal workings should be hidden. Declaring attributes as `private` prevents direct external manipulation of data, which aligns with the principle of keeping the interface minimal. If an attribute is `public`, it breaks the concept of data hiding.

*   **`public` Members**: Conversely, `public` methods and constructors define the **services a class offers to other objects**, forming its external Application Programming Interface (API). These are the parts of your class that other developers or client code are intended to interact with. For instance, a car''s steering wheel or accelerator pedal are part of its public interface.

Here''s a simple illustration of `private` attributes and `public` methods in Java:

```java
public class BankAccount {
    // private attribute: This data can only be accessed/modified from within this class
    private double balance; 
    private String accountNumber;

    // Public Constructor: Allows other objects to create a BankAccount instance
    public BankAccount(String accNum, double initialBalance) {
        this.accountNumber = accNum;
        this.balance = initialBalance;
        System.out.println("Account " + accNum + " created with balance: " + initialBalance);
    }

    // Public method: Part of the public interface, allows depositing money
    public void deposit(double amount) {
        if (amount > 0) {
            this.balance += amount;
            System.out.println(amount + " deposited. New balance: " + this.balance);
        } else {
            System.out.println("Deposit amount must be positive.");
        }
    }

    // Private helper method: Internal logic, not directly accessible from outside
    private boolean isValidTransaction(double amount) {
        return amount > 0 && this.balance >= amount;
    }
}
```

```mermaid
graph TD
    A[Client Code] --> |Calls Public Methods| B(BankAccount Public Interface)
    B --> |Interacts with| C{Private Attributes & Methods}
    C --x |Direct Access Denied| A
```

As you can see, `balance` and `accountNumber` are `private`, meaning no external code can directly change `myAccount.balance = 1000.0;`. This forces interaction through the defined `public` methods, maintaining control.

## Using Getters and Setters

Since `private` members are hidden, how do other objects inspect or modify them? This is where **accessor methods**, commonly known as **''getters'' and ''setters''**, come into play. They provide a **controlled gateway** for other objects to interact with a class''s private attributes.

*   **Getters (Accessor Methods)**: These are `public` methods designed to **retrieve (get)** the value of a `private` attribute. They allow other objects to *read* the data without having direct modification access.

*   **Setters (Mutator Methods)**: These are `public` methods designed to **modify (set)** the value of a `private` attribute. Setters are particularly powerful because they can include **validation logic** or other business rules before the data is actually set, ensuring data integrity. They act as a control point, preventing unintended or malicious manipulation of data. If a bug occurs related to an attribute, with setters, you only need to look in one place (the setter method) rather than searching through all external code that might have directly changed a public attribute.

Let''s extend our `BankAccount` example to include getters and setters:

```java
public class BankAccount {
    private double balance;
    private String accountNumber;
    private String accountHolderName;

    public BankAccount(String accNum, double initialBalance, String holderName) {
        this.accountNumber = accNum;
        this.balance = initialBalance;
        this.accountHolderName = holderName;
        System.out.println("Account " + accNum + " created for " + holderName + " with balance: " + initialBalance);
    }

    // Getter for balance
    public double getBalance() {
        return this.balance;
    }

    // Getter for accountHolderName
    public String getAccountHolderName() {
        return this.accountHolderName;
    }

    // Setter for accountHolderName with validation
    public void setAccountHolderName(String newName) {
        // Example of validation logic inside a setter
        if (newName != null && !newName.trim().isEmpty()) {
            this.accountHolderName = newName.trim();
            System.out.println("Account holder name updated to: " + this.accountHolderName);
        } else {
            System.out.println("Error: Account holder name cannot be empty.");
        }
    }

    // Public method for withdrawing money, which uses setters implicitly or relies on internal logic
    public void withdraw(double amount) {
        if (amount > 0 && this.balance >= amount) {
            this.balance -= amount;
            System.out.println(amount + " withdrawn. New balance: " + this.balance);
        } else {
            System.out.println("Withdrawal failed. Insufficient funds or invalid amount.");
        }
    }

    // ... other methods ...
}

public class ClientApp {
    public static void main(String[] args) {
        BankAccount myAccount = new BankAccount("123456789", 1000.0, "Alice Smith");

        // Using a getter to read the balance
        System.out.println("Current balance: " + myAccount.getBalance());

        // Using a setter to change the account holder''s name with validation
        myAccount.setAccountHolderName("Alice Johnson");
        myAccount.setAccountHolderName(""); // This will trigger the validation error

        // Attempting to withdraw money (behavior interacting with internal state)
        myAccount.withdraw(200.0);
        myAccount.withdraw(1500.0); // This will fail due to insufficient funds
    }
}
```

By diligently using `private` access for attributes and `public` getters/setters for controlled access, you foster **encapsulation**, making your classes **more robust, secure, and easier to manage and debug** [5, 97a48d3a-8282-4216-a58b-cbf75d3c7023]. This approach ensures that your object''s internal state remains consistent and valid, regardless of how other parts of the program interact with it.', 'Controlled Data Access with Accessors', 'This lesson covers Controlled Data Access with Accessors in OOP. It emphasizes declaring class attributes as `private` and providing `public` getter and setter methods to control access. Getters allow safe reading of data');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('bee88569-4567-4b2e-89ec-de60bc596bc0', '## Navigating Abstraction: Abstract Classes vs. Interfaces

In the world of Object-Oriented Programming (OOP), **abstraction** is a cornerstone principle that helps us manage complexity by hiding intricate implementation details and revealing only the essential features. Two powerful tools for achieving abstraction in languages like Java are **abstract classes** and **interfaces**. While they both allow you to define abstract methods – methods without an implementation – their roles and appropriate use cases differ significantly. Understanding these distinctions is crucial for designing robust, flexible, and maintainable systems.

### What is an Abstract Class?

An **abstract class** is a class that cannot be instantiated directly. Think of it as a blueprint for a blueprint. It can contain both **abstract methods** (methods declared without an implementation) and **concrete methods** (methods with an implementation). If a class has at least one abstract method, it *must* be declared an abstract class. Subclasses that extend an abstract class *must* provide implementations for all its abstract methods, unless they are also declared abstract.

The primary purpose of an abstract class is to provide a common base for related classes, allowing for partial implementation and shared behaviours. A class can only **extend one abstract class**. This forms an ''is-a'' relationship, where the subclass is a more specific type of the abstract superclass.

Let''s consider an example of a `Mammal` abstract class:

```java
public abstract class Mammal {
    // A concrete method with an implementation
    public void generateHeat() {
        System.out.println("Generating internal heat...");
    }

    // An abstract method without implementation; subclasses must define this
    public abstract void makeSound();
}

// A concrete subclass implementing the abstract method
public class Dog extends Mammal {
    @Override
    public void makeSound() {
        System.out.println("Bark!");
    }
}

// Another concrete subclass
public class Cat extends Mammal {
    @Override
    public void makeSound() {
        System.out.println("Meow!");
    }
}

public class AnimalShelter {
    public static void main(String[] args) {
        Dog fido = new Dog();
        Cat whiskers = new Cat();

        fido.generateHeat(); // Inherited concrete method
        fido.makeSound();    // Implemented abstract method

        whiskers.generateHeat();
        whiskers.makeSound();

        // Mammal genericMammal = new Mammal(); // This would cause a compile-time error!
    }
}
```

In this UML diagram, you can see `Mammal` as an abstract class (italicised name) and its relationship with `Dog` and `Cat`:

```mermaid
classDiagram
    %% Define the abstract class and its methods
    class Mammal {
        <<abstract>>
        +generateHeat()
        +makeSound()
    }

    %% Define the concrete classes
    class Dog {
        +makeSound()
    }

    class Cat {
        +makeSound()
    }

    %% Define the inheritance relationships
    Mammal <|-- Dog
    Mammal <|-- Cat
```

### What is an Interface?

An **interface**, by contrast, is a **contract** that specifies a set of abstract methods that a class *must* implement. Unlike abstract classes, an interface **cannot provide any implementation details** whatsoever; all its methods are implicitly abstract (and public).

Interfaces are used to define a **blueprint for behaviour** or capabilities, without dictating how those capabilities are achieved. A class can **implement multiple interfaces**, which is a key differentiator from abstract classes. This is often described as a ''behaves-like-a'' relationship, defining what an object *can do*, rather than what it *is*.

Consider an interface for objects that can be named:

```java
public interface Nameable {
    String getName();
    void setName(String name);
}

// A class implementing the Nameable interface
public class Car implements Nameable {
    private String brandName;

    public Car(String brand) {
        this.brandName = brand;
    }

    @Override
    public String getName() {
        return brandName;
    }

    @Override
    public void setName(String name) {
        this.brandName = name;
    }

    public void drive() {
        System.out.println(brandName + " is driving.");
    }
}

// Another unrelated class implementing Nameable
public class Planet implements Nameable {
    private String planetName;

    public Planet(String name) {
        this.planetName = name;
    }

    @Override
    public String getName() {
        return planetName;
    }

    @Override
    public void setName(String name) {
        this.planetName = name;
    }

    public void orbit() {
        System.out.println(planetName + " is orbiting.");
    }
}

public class NamingService {
    public static void main(String[] args) {
        Car myCar = new Car("Tesla");
        Planet earth = new Planet("Earth");

        System.out.println("Car name: " + myCar.getName());
        System.out.println("Planet name: " + earth.getName());

        // Demonstrating polymorphism via interface
        Nameable namedObject1 = myCar;
        Nameable namedObject2 = earth;

        System.out.println("Named object 1: " + namedObject1.getName());
        System.out.println("Named object 2: " + namedObject2.getName());
    }
}
```

And its UML representation, showing the dashed line for interface implementation:

```mermaid
classDiagram
    class Nameable {
        +getName()
        +setName()
    }
    <<interface>> Nameable
    Car ..|> Nameable
    Planet ..|> Nameable
    Car : +drive()
    Planet : +orbit()
```

### Distinguishing Their Roles

The fundamental difference lies in their intent and capabilities. **Abstract classes** are best suited for situations where you have a clear ''is-a'' hierarchy and some common implementation that all subclasses can share. They allow you to define common behaviour *and* mandate specific behaviour. You''d use an abstract class when you want to create a base for a group of closely related classes, providing a template with some pre-built functionality.

**Interfaces**, on the other hand, are ideal for defining **contracts for behaviour** across potentially unrelated classes. They define *what* a class should do, without specifying *how*. This promotes **loose coupling** and **flexibility**, as classes can implement multiple interfaces to gain different sets of capabilities. You''d use an interface when you want to define a capability (e.g., `Printable`, `Sortable`) that many different types of objects, possibly from different hierarchies, might possess.

| Feature           | Abstract Class                                 | Interface                                     |
|-------------------|------------------------------------------------|-----------------------------------------------|
| **Purpose**       | Common base for related classes, partial implementation | Define capabilities/contracts for behaviour |
| **Implementation**| Can have concrete and abstract methods | All methods are abstract (no implementation) |
| **Inheritance**   | A class can extend only one abstract class | A class can implement multiple interfaces |
| **Relationship**  | ''is-a'' relationship (specialisation) | ''behaves-like-a'' relationship (contract) |

### The Challenge of Multiple Inheritance and Its Alternatives

**Multiple inheritance** is a concept where a class can inherit attributes and methods from **more than one parent class**. While this might seem appealing for modelling complex real-world scenarios (like a child inheriting traits from two parents), it introduces significant **system complexity**. This complexity arises from issues such as the "diamond problem" (ambiguity when a class inherits from two classes that share a common ancestor, leading to duplicate methods or attributes) and increased difficulty for compilers and developers in managing the inheritance hierarchy.

Because of these complexities, many modern object-oriented languages, including **Java, .NET, and Swift, generally do not support conventional multiple inheritance** for implementation. Instead, they **prefer interfaces for behavioural inheritance**.

Interfaces provide a powerful alternative: they allow classes to inherit *behavioural contracts* from multiple sources without inheriting *implementation details* (and thus avoiding the complexities associated with inheriting state or conflicting method implementations from multiple parents). This means you can design a class that acts like a `Nameable` and a `Printable` and a `Sortable` object, even if those capabilities come from entirely different conceptual "families" or hierarchies. This approach ensures that while a class can conform to multiple contracts for behaviour, the actual *how-to* is always provided by a single class, simplifying the underlying implementation and reducing complexity.

By understanding when to use an abstract class for true ''is-a'' generalisation and when to use interfaces for flexible ''behaves-like-a'' contracts, developers can create highly modular, extensible, and maintainable object-oriented designs, even in the absence of traditional multiple inheritance.', 'Interfaces, Abstract Classes, and the Inheritance Dilemma', 'This lesson explains how abstract classes provide a common base with shared behavior for related classes (‘is-a’ relationship), while interfaces define contracts for capabilities that unrelated classes can implement (‘behaves-like’ relationship). It also covers how interfaces offer a flexible alternative to multiple inheritance for modular, maintainable OOP designs.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('344a3249-fb11-4666-8fec-1df09e0553c4', '# Achieving Polymorphism: Flexible Design with Overriding and Abstraction

Object-Oriented Programming (OOP) is built upon several core principles that enable the creation of flexible, reusable, and maintainable software. Among these, **polymorphism** stands out as a particularly powerful concept. The term polymorphism itself comes from Greek, meaning **"many shapes"**. In OOP, this means that objects of different classes can be treated as objects of a common type, allowing them to respond to the same message in different ways depending on their specific type. This fundamental capability significantly enhances a system''s flexibility and extensibility.

## Implementing Polymorphism via Method Overriding

One of the primary ways to achieve polymorphism in object-oriented languages is through **method overriding**. This occurs when a **subclass provides a specific implementation of a method that is already defined in its superclass**. The superclass declares the method, establishing a common interface, but each subclass can define its own unique behaviour for that method.

Consider an `Animal` superclass with a `makeSound()` method. While an `Animal` can make a generic sound, a `Dog` subclass can override this method to produce a "Woof!" sound, and a `Cat` subclass can override it to produce a "Meow!" sound. This allows you to treat both `Dog` and `Cat` objects as `Animal` objects, yet when `makeSound()` is called, each will perform its specific action. The individual object is responsible for its own behaviour.

Let''s illustrate this with a classic `Shape` example. Imagine an abstract concept of a `Shape` that can be "drawn". While you can''t draw a generic "shape," you can draw a `Circle` or a `Rectangle`.

```java
// Superclass: Defines the common interface
abstract class Shape {
    // Abstract method: must be implemented by subclasses
    public abstract void draw(); 
}

// Subclass: Provides its specific implementation of draw()
class Circle extends Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a Circle");
    }
}

// Subclass: Provides its specific implementation of draw()
class Rectangle extends Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a Rectangle");
    }
}

public class PolymorphismDemo {
    public static void main(String[] args) {
        // Create objects of different concrete types
        Shape circle = new Circle();
        Shape rectangle = new Rectangle();

        // Call the draw method on objects treated as the common type (Shape)
        // Each object responds based on its specific implementation
        circle.draw();    // Output: Drawing a Circle
        rectangle.draw(); // Output: Drawing a Rectangle
    }
}
```

In this example, `Circle` and `Rectangle` both extend `Shape` and **override** the `draw()` method. When `circle.draw()` is called, the `Circle`''s specific `draw()` implementation is executed, and similarly for `rectangle.draw()`. This demonstrates how the same message (`draw()`) sent to different objects (of types `Circle` and `Rectangle`, treated as `Shape`) results in different, type-specific behaviours.

## Understanding and Applying Abstraction with Abstract Classes/Methods

Polymorphism often goes hand-in-hand with **abstraction**. Abstraction is the process of **hiding complex implementation details and only showing the essential features** of an object. In OOP, this is frequently achieved using **abstract classes** and **abstract methods**.

An **abstract class** is a class that **cannot be instantiated** directly. It exists to define a **common interface** and often provides a partial implementation for its subclasses. What makes a class abstract is the presence of one or more **abstract methods** within it. An abstract method is declared without an implementation; it specifies a contract that **subclasses must implement**. If a subclass does not provide an implementation for all inherited abstract methods, it too must be declared as an abstract class.

Consider our `Shape` example again. A generic `Shape` is an abstract concept; you can''t physically instantiate it. However, all shapes have an area, even if the calculation differs. Thus, `Shape` can declare an abstract method `getArea()`:

```java
// Abstract Class: Cannot be instantiated directly
abstract class Shape {
    // Abstract method: Defines a contract for calculating area
    public abstract double getArea(); 
}

// Concrete Subclass: Must implement the abstract method
class Circle extends Shape {
    private double radius;

    public Circle(double r) {
        this.radius = r;
    }

    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
}

// Concrete Subclass: Must implement the abstract method
class Rectangle extends Shape {
    private double length;
    private double width;

    public Rectangle(double l, double w) {
        this.length = l;
        this.width = w;
    }

    @Override
    public double getArea() {
        return length * width;
    }
}

public class AbstractionDemo {
    public static void main(String[] args) {
        // You cannot create an instance of an abstract class directly:
        // Shape myShape = new Shape(); // This would result in a compile-time error

        // Create instances of concrete subclasses
        Shape circle = new Circle(5.0);
        Shape rectangle = new Rectangle(4.0, 6.0);

        // Call getArea() polymorphically
        System.out.println("Area of Circle: " + circle.getArea());       // Output: Area of Circle: 78.53981633974483
        System.out.println("Area of Rectangle: " + rectangle.getArea()); // Output: Area of Rectangle: 24.0
    }
}
```

This structure ensures that any class deriving from `Shape` **guarantees** it can `getArea()`, while leaving the specific calculation to each subclass. This hides the "how" (the specific area calculation logic) and exposes only the "what" (the ability to get an area), which is the essence of abstraction.

## The Power of Polymorphism and Abstraction in Design

By combining method overriding and abstract classes, developers can design highly flexible systems where new types can be added with minimal impact on existing code. The power lies in treating diverse objects uniformly through a common abstract interface, allowing the objects themselves to determine their specific response.

For example, you could have a collection of `Shape` objects (circles, rectangles, and any new shapes added in the future), and iterate through them, calling `getArea()` on each without needing to know their specific concrete type. Each object will know how to calculate its own area because it has overridden the `getArea()` method.

Here''s a visual representation of the `Shape` hierarchy:

```mermaid
classDiagram
    Shape <|-- Circle
    Shape <|-- Rectangle

    class Shape {
        <<abstract>>
        +getArea()
    }

    class Circle {
        -radius: double
        +getArea()
    }

    class Rectangle {
        -length: double
        -width: double
        +getArea()
    }
```

This diagram clearly shows `Shape` as an abstract class, serving as the common blueprint, and `Circle` and `Rectangle` as concrete subclasses that provide their unique implementations for the `getArea()` method. This design pattern is central to building robust and scalable object-oriented applications.', 'Achieving Polymorphism: Flexible Design with Overriding and Abstraction', 'This lesson explains that polymorphism allows objects of different classes to be treated as a common type, letting them respond differently to the same method call. It shows how method overriding and abstract classes/methods enable this flexibility, allowing developers to write generic, extensible code while hiding implementation details (abstraction).');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('1b6f4bd4-6af5-4095-ad7f-69978772bc3b', '## Building Blocks: Understanding Object Relationships with Composition

In Object-Oriented Programming (OOP), one of the fundamental aspects of designing robust and flexible systems is understanding how classes and objects relate to each other. While **inheritance** is a powerful tool for defining ''is-a'' relationships, **composition** offers an equally vital, and often more flexible, way to build complex objects through ''has-a'' relationships. Deciding which approach to use is a crucial design decision that impacts the maintainability and extensibility of your software.

### Inheritance: The ''Is-a'' Relationship Revisited

**Inheritance** allows a new class (subclass) to derive properties and behaviours from an existing class (superclass). This mechanism promotes **code reusability** and helps establish clear **hierarchical relationships** between classes. It models an **`is-a` relationship**, signifying that a subclass is a more specific type of its superclass. For example, a `Dog` **`is an`** `Animal`. The subclass inherits the methods and attributes of its parent, specialising its behaviour while retaining common characteristics.

Consider a simple inheritance hierarchy:

```java
// Superclass
public class Animal {
    public void eat() {
        System.out.println("This animal eats.");
    }

    public void sleep() {
        System.out.println("This animal sleeps.");
    }
}

// Subclass extending Animal
public class Dog extends Animal {
    public void bark() {
        System.out.println("Woof! Woof!");
    }

    // Dog ''is an'' Animal, so it inherits eat() and sleep()
    public static void main(String[] args) {
        Dog myDog = new Dog();
        myDog.eat();   // Inherited behaviour
        myDog.bark();  // Dog-specific behaviour
    }
}
```

In UML, this is depicted with a solid line and an unfilled triangle pointing to the superclass:

```mermaid
classDiagram
    Animal <|-- Dog
    Animal : +eat()
    Animal : +sleep()
    Dog : +bark()
```

### Composition: The ''Has-a'' Relationship for Flexibility

In contrast to inheritance, **composition** is a design technique where one class contains instances of other classes as its members. This represents a **`has-a` relationship**, meaning an object `has an` instance of another object. Instead of a subclass inheriting functionality, a class *uses* the functionality of another object by holding a reference to it.

**Composition promotes code reuse and flexibility** by allowing **independent development and reuse of components**. Think of it like assembling a complex machine from smaller, independent parts. For instance, a `Car` **`has an`** `Engine`. The `Engine` is a separate, self-contained object that handles its own responsibilities (like combustion and power generation). The `Car` object simply contains an `Engine` object and delegates engine-related tasks to it. This means the `Engine` can be reused in different types of vehicles, or even other machines, without the `Car` needing to *be* an `Engine`. This modularity simplifies testing and maintenance, as changes to the `Engine` class (as long as its public interface remains consistent) won''t directly impact the `Car`''s internal structure.

Here''s how you might implement a `Car` and `Engine` using composition:

```java
// The ''contained'' class or component
public class Engine {
    private String type;

    public Engine(String type) {
        this.type = type;
    }

    public void start() {
        System.out.println(type + " engine starting...");
    }

    public void stop() {
        System.out.println(type + " engine stopping.");
    }
}

// The ''container'' class using composition
public class Car {
    private String make;
    private Engine engine; // Car ''has an'' Engine

    public Car(String make, String engineType) {
        this.make = make;
        this.engine = new Engine(engineType); // Instantiate the Engine within the Car
    }

    public void drive() {
        System.out.println(make + " car is driving.");
        engine.start(); // Delegate behaviour to the contained object
    }

    public static void main(String[] args) {
        Car myCar = new Car("Toyota", "V6");
        myCar.drive();
        // The car uses the engine''s functionality without inheriting from it.
    }
}
```

In UML, composition (specifically, a strong form called composition) is represented by a solid diamond on the containing class side, connected to the contained class.

```mermaid
classDiagram
    Car "1" *-- "1" Engine : contains
    Car : +make
    Car : +drive()
    Engine : +type
    Engine : +start()
    Engine : +stop()
```

### Diving Deeper: Aggregation and Association

While composition generally refers to the ''has-a'' relationship, it can be further broken down into **aggregation** and **association**. These distinctions relate to the strength of the relationship and the lifecycle of the contained object:

*   **Aggregation**: This is a weaker ''part-of'' relationship. The contained object (the part) can exist independently of the container object (the whole). For example, a `Department` `has a` `Professor`, but a `Professor` can exist without being part of that specific `Department`. The `Professor`''s lifecycle is not dependent on the `Department`. In UML, aggregation is shown with an **unfilled diamond** on the ''whole'' side.

*   **Association**: This is the most general `has-a` relationship, representing objects that interact or are connected, but neither is necessarily a ''part-of'' the other in a physical sense. It often signifies one object *using the services* of another. For example, a `Student` might be `associated with` a `Course`. In UML, a simple line indicates an association.

Understanding **cardinality** is also crucial, as it specifies how many objects participate in a relationship and whether participation is optional or mandatory. For example, a `Car` has **one (`1`)** `Engine`, but a `Department` might have **many (`1..*`)** `Employees`.

```mermaid
classDiagram
    Department "1" o-- "*" Professor : teaches
    Department "1" -- "*" Employee : employs

    Department : +name
    Professor : +name
    Employee : +id
```

### Choosing Between Inheritance and Composition

Deciding between inheritance and composition is **one of the most critical design decisions** when building flexible, maintainable, and robust software systems. The classic litmus test is:

*   If `Class B` **`is a`** `Class A`, then **inheritance** might be appropriate. This implies a strong specialisation and hierarchy.
*   If `Class B` **`has a`** `Class A` (or `uses` a `Class A`), then **composition** is likely the better choice. This implies that `Class A` is a component or a service used by `Class B`.

While inheritance is fundamental for code reuse, it can sometimes **weaken encapsulation**. Changes in a superclass can sometimes have **unintended ripple effects** through its subclasses, making testing and maintenance more complex. For example, if a `Bird` class has a `fly()` method, what about a `Penguin` that cannot fly? Using inheritance here might force a problematic override or an unintuitive design.

**Composition, on the other hand, offers greater flexibility and reduces tight coupling**. When a class is composed of other objects, changes in the internal implementation of a component (like `Engine`) don''t necessarily require changes to the consuming class (`Car`), as long as the component''s public interface remains consistent. This leads to more modular and independent code. Many modern OOP practices, influenced by principles like **SOLID**, often **favour composition over inheritance** to avoid issues such as rigidity, fragility, and immobility in code, promoting systems that are easier to extend and maintain. This is particularly evident with the **Dependency Inversion Principle (DIP)**, which advocates depending on abstractions (interfaces) rather than concrete implementations, a goal often achieved through **dependency injection** (where dependencies are ''injected'' into an object rather than created directly within it).

In summary, both inheritance and composition are powerful tools in your OOP toolkit. The key is to **understand their distinct roles and apply them judiciously** to create well-structured, flexible, and maintainable software designs.', 'Composition for Object Relationships: Building with ''Has-a''', 'This lesson explains how composition (‘has-a’ relationships) in OOP lets classes build complex, flexible objects by containing and delegating to other objects, contrasting it with inheritance (‘is-a’ relationships). It also covers aggregation, association, and guidelines for choosing the right relationship for maintainable, modular designs.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('cded15bd-d98e-4da6-accc-0cdcd72086a8', '## Interfaces: Forging Contracts in Object-Oriented Design

In the world of Object-Oriented Programming (OOP), **interfaces** serve as powerful tools for establishing **contracts**. Think of a contract in the real world: it''s a binding agreement that specifies what parties must do without dictating *how* they do it. In programming, an interface acts as a blueprint for behaviour, defining a set of abstract methods that any class *implementing* it must adhere to.

This principle promotes **abstraction**, allowing you to focus on *what* a class does rather than *how* it achieves it. It also fosters **standardisation**, ensuring that different classes can provide a common functionality, making your code more flexible, reusable, and maintainable.

### Defining an Interface

To define an interface, you use the `interface` keyword. Within an interface, all methods are implicitly `public` and `abstract` (though you can explicitly declare them as such). This means you specify the method signature (its name, parameters, and return type), but **you do not provide any implementation details** or code within the interface methods themselves. An interface is purely about defining a **contract for behaviour**.

For example, if we want to ensure that various shapes in our system can all calculate their area, we can define a `Shape` interface:

```java
// This KC covers the syntax and purpose of defining an interface,
// which acts as a contract specifying a set of abstract methods.
public interface Shape {
    double calculateArea(); // No implementation here, just the contract
}
```

Notice that there''s no code inside `calculateArea()`. The `Shape` interface simply declares that any class agreeing to be a `Shape` *must* provide a `calculateArea()` method. This establishes a clear **contract**.


### Implementing an Interface

Once an interface is defined, a class can **implement** it using the `implements` keyword. When a class implements an interface, it is **contractually obligated** to provide concrete implementations for *all* the abstract methods declared in that interface. If a class fails to implement even one method from the interface, it itself becomes an abstract class (or simply won''t compile, depending on the language and context).

This process ensures that the class provides the specific functionalities promised by the interface, making it compatible with other components designed to interact with that interface. It''s how an **abstract design** (the interface) is translated into a **functional component** (the concrete class).

Let''s implement our `Shape` interface with a `Circle` class:

```java
// This KC involves creating a concrete class that adheres to an interface''s contract
// by providing implementations for all its abstract methods.
public class Circle implements Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public double calculateArea() {
        return Math.PI * radius * radius; // Concrete implementation for Circle
    }
}
```

Here, the `Circle` class explicitly `implements Shape` and provides its own unique way of `calculateArea()`. Now, any part of your system that expects a `Shape` can interact with a `Circle` object, knowing for certain it has a `calculateArea()` method.

Similarly, a `Rectangle` class would implement the same `Shape` interface, but with its own `calculateArea()` logic:

```java
public class Rectangle implements Shape {
    private double length;
    private double width;

    public Rectangle(double length, double width) {
        this.length = length;
        this.width = width;
    }

    @Override
    public double calculateArea() {
        return length * width; // Concrete implementation for Rectangle
    }
}
```

### Fulfilling Abstract Contracts: The Power of Polymorphism

The real power of interfaces as contracts becomes evident with **polymorphism**. Since `Circle` and `Rectangle` both implement the `Shape` interface, they can be treated as `Shape` objects. This allows for writing generic code that can operate on various implementing classes interchangeably, enhancing flexibility and reusability. You can send the same message (`calculateArea()`) to different objects (a `Circle` or a `Rectangle`), and each object will respond according to its own concrete implementation, fulfilling the contract.

Consider the following scenario where we have an array of `Shape` objects:

```java
public class AreaCalculator {
    public static void main(String[] args) {
        Shape circle = new Circle(5.0); // Circle is a Shape
        Shape rectangle = new Rectangle(4.0, 6.0); // Rectangle is a Shape

        System.out.println("Area of Circle: " + circle.calculateArea());
        System.out.println("Area of Rectangle: " + rectangle.calculateArea());

        // You can even put them in a collection of Shapes
        Shape[] shapes = new Shape;
        shapes = circle;
        shapes = rectangle;

        for (Shape s : shapes) {
            // The contract ensures that every Shape has a calculateArea() method
            System.out.println("Calculated Area: " + s.calculateArea());
        }
    }
}
```

In this code, `s.calculateArea()` works seamlessly for both `Circle` and `Rectangle` objects because the `Shape` interface guarantees that this method exists and is implemented by all concrete classes. This means you can write code that is decoupled from specific implementations, making your system more extensible. If you add a new `Triangle` class implementing `Shape`, the `AreaCalculator` doesn''t need to change, as long as the new class adheres to the `Shape` contract.

Interfaces enable a "behaves-like-a" relationship, unlike strict inheritance which is an "is-a" relationship. For example, a `Dog` **is-a** `Mammal` (inheritance), but a `Dog` **behaves-like-a** `Nameable` (interface), just as a `Car` or `Planet` can also **behave-like-a** `Nameable`. This allows unrelated classes to share a common functional contract.

Here’s a visual representation of how interfaces act as contracts for different, potentially unrelated, classes:

```mermaid
graph TD
    I_Nameable["«interface» Nameable"]
    C_Dog[Dog]
    C_Car[Car]
    C_Planet[Planet]

    I_Nameable -- "implements getName(), setName()" --> C_Dog
    I_Nameable -- "implements getName(), setName()" --> C_Car
    I_Nameable -- "implements getName(), setName()" --> C_Planet

    subgraph "Ensures Common Naming Behavior"
        C_Dog
        C_Car
        C_Planet
    end

    style I_Nameable fill:#f9f,stroke:#333,stroke-width:2px,stroke-dasharray: 5 5
```

Interfaces are a cornerstone of robust, flexible, and maintainable object-oriented systems, providing a way to define strict behavioural contracts that promote high cohesion and loose coupling within your software architecture. They help manage complexity by ensuring consistency in how objects interact, even when their internal implementations differ.', 'Interfaces as Contracts', 'This lesson explains that interfaces act as contracts in OOP, defining a set of methods that any implementing class must provide. They enable polymorphism, letting different classes be used interchangeably, and promote flexible, decoupled, and maintainable code by focusing on what an object does rather than how it does it.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('df7f776a-f96b-4347-be09-88d458ced907', '## Designing Interfaces That Work for Everyone (And Last!)

In the world of Object-Oriented Programming (OOP), designing interfaces is far more than just creating buttons and menus. It''s about crafting the very way different parts of your system, and indeed real-world users, interact with your software. The goal is to build something intuitive, secure, and, crucially, **reusable**. To achieve this, we must adopt a user-centric approach and ensure our designs are abstract enough to stand the test of time and changing requirements.

### Identifying All Class Users for Effective Interface Design

Before you even think about writing a single line of code for an interface, you must identify **all potential users of a class or system**. This isn''t just about the person clicking buttons on a screen. In OOP, users can include: 

*   **End-customers:** The actual human beings interacting with your software.
*   **Other interacting objects:** Other classes or components within your system that will send messages to or receive services from your class.
*   **Internal roles:** Consider the different roles within your system that might interact with a class, such as a ''cabbie'' in a taxi system who needs to provide a service, not just consume one.

Failing to identify all users can lead to an interface that, while seemingly perfect for one group, is unusable or even problematic for another. For instance, in a taxi system, a customer''s ideal interface might be "Take me to the airport for free". However, for the ''cabbie'' (another user of the system), this is clearly unsustainable. A realistic and usable interface must satisfy the varied requirements and constraints of all interacting parties. This process involves **brainstorming all potential entities** that might send messages to or receive services from your class.

Consider the fundamental methods that a `Cabbie` class might need for interaction:

```java
public class Cabbie {
    // ... attributes ...

    // Methods that the customer (external user/object) might invoke:
    public void giveDestination(String destination) { /* ... */ }
    public void payCabbie(double amount) { /* ... */ }
    public void tipCabbie(double tip) { /* ... */ }
    
    // Methods an internal system (or the Cabbie themselves) might invoke or rely on:
    // (Some of these might be private implementation details, but their *need* comes from user interaction)
    private void calculateFare(String destination) { /* ... */ }
    private void updateLocation() { /* ... */ }
    public String getCurrentStatus() { /* ... */ }
    // ... and so on.
}
```

By considering both the passenger''s desire to arrive at a destination and the cabbie''s need to earn a living and navigate, you begin to shape a more robust and functional interface.

### Determining Object Behaviors and Environmental Constraints

Once you have a clear picture of all your users, the next step is to **determine the necessary behaviours (methods) of an object from their perspective**. This is about translating user needs and system limitations into observable actions that your object can perform.

Tools like **UML Use Cases** are invaluable for gathering these requirements. They help you list what the system (or a specific object within it) must do to perform properly. For example, a `DataBaseReader` class would need methods to open/close connections, navigate records, and retrieve data. These are its behaviours from the perspective of a programmer using it.

However, it''s not enough to just consider user desires. You must also account for **environmental constraints**. These are external limitations that might affect an object''s functionality. Examples include:

*   **Computer hardware limits:** Such as memory or processing power.
*   **Network availability:** Is an internet connection always guaranteed?
*   **External dependencies:** Are there specific APIs or third-party services you *must* integrate with?
*   **Real-world limitations:** For our taxi example, a cab cannot drive on a road if a bridge is out, regardless of what the user wants.

These constraints directly influence what behaviours are feasible and how they should be implemented. They guide the design towards what is realistic and achievable within the given environment.

For instance, if your system relies on a database, you need to define methods that handle database interactions:

```java
public class DataBaseReader {
    public void open(String dbName) { /* Connect to DB */ }
    public void close() { /* Close DB connection */ }
    public void goToFirst() { /* Move cursor to first record */ }
    public String getNextRecord() { /* Fetch next record */ }
    public boolean hasMoreRecords() { /* Check if more records exist */ }
    // ... other essential methods
}
```

Notice that the internal details of *how* these operations are performed (e.g., which specific database API is used) are hidden; only the public methods are exposed. This leads us to our next principle.

### Designing Abstract Interfaces for Reusability

A fundamental goal of good OOP design is to create **reusable classes**. One of the most powerful ways to achieve this is by designing **abstract interfaces**. An abstract interface provides the functionality users need without exposing internal implementation details, promoting reusability and simplifying usage.

Consider the difference between a concrete and an abstract instruction for a taxi:

*   **Concrete:** "Turn right, then left, then right again." (Very specific, not reusable for other journeys)
*   **Abstract:** "Take me to the airport." (General user goal, reusable in any city)

Designing with a **minimal public interface** is key here. You expose only what external users **absolutely need** to interact with the class, nothing more. This simplifies class usage, enhances security by controlling data access, and prevents unnecessary coupling between classes. Think of it as initially offering no public interfaces and only adding them when explicitly required or identified through user feedback.

An abstract interface acts as a **contract** for behaviour without providing implementation details. Classes that ''implement'' this interface agree to provide specific functionalities, making them compatible with other components designed to interact with that interface. This promotes loose coupling, making your code more modular, maintainable, and extensible.

Here’s a Java example of an abstract interface for transportation:

```java
// Defining an abstract interface for transport services
public interface TransportService {
    // A common, abstract goal
    void goToDestination(String destination);

    // Other necessary abstract behaviors
    double calculateFare(String destination);
    void startService();
    void endService();
}

// Concrete implementation for a Taxi
public class Taxi implements TransportService {
    @Override
    public void goToDestination(String destination) {
        System.out.println("Taxi driving to: " + destination);
        // ... complex navigation logic ...
    }

    @Override
    public double calculateFare(String destination) {
        // ... specific fare calculation for taxi ...
        return 2.50 * destination.length(); // Simplified for example
    }

    @Override
    public void startService() {
        System.out.println("Taxi service started.");
    }

    @Override
    public void endService() {
        System.out.println("Taxi service ended.");
    }
}

// Another concrete implementation for a Bus
public class Bus implements TransportService {
    private String route;

    public Bus(String route) {
        this.route = route;
    }

    @Override
    public void goToDestination(String destination) {
        System.out.println("Bus on route " + route + " heading towards: " + destination);
        // ... bus route logic ...
    }

    @Override
    public double calculateFare(String destination) {
        return 1.50; // Flat fare for bus
    }

    @Override
    public void startService() {
        System.out.println("Bus service started on route " + route);
    }

    @Override
    public void endService() {
        System.out.println("Bus service ended on route " + route);
    }
}
```

This abstract design allows you to use different `TransportService` implementations interchangeably, promoting flexibility and reusability across your application. You can even add new transportation methods (e.g., `Train`, `Airplane`) without altering the code that uses the `TransportService` interface, as long as they adhere to the contract. This is the power of programming to an interface rather than a concrete implementation.

By focusing on the user''s ultimate goal (e.g., getting to the airport) rather than the minute steps (e.g., turning left or right), you create interfaces that are not only more user-friendly but also far more adaptable and reusable in various specific contexts.

```mermaid
classDiagram
    direction LR
    class TransportService{
        <<interface>>
        +goToDestination(destination: String)
        +calculateFare(destination: String): double
        +startService()
        +endService()
    }

    class Taxi{
        +goToDestination(destination: String)
        +calculateFare(destination: String): double
        +startService()
        +endService()
    }

    class Bus{
        +goToDestination(destination: String)
        +calculateFare(destination: String): double
        +startService()
        +endService()
    }

    TransportService <|.. Taxi : Implements
    TransportService <|.. Bus : Implements
```

In summary, building robust and reusable software means starting with a deep understanding of *all* users, carefully defining necessary behaviours within environmental limits, and abstracting those behaviours into minimal, flexible interfaces. This thoughtful approach ensures your classes are not just functional, but truly adaptable and long-lasting assets in your software toolkit.', 'User-Centric & Reusable Interface Design', 'This lesson is about designing user-centric and reusable interfaces in OOP. It emphasizes understanding all users of a class, defining object behaviors within environmental constraints, and creating abstract interfaces so that classes are flexible, maintainable, and can be reused across different contexts.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('c5c232d1-7640-42d8-9517-795d094190fa', '### Building Blocks of an Object: Attributes and Methods

Every object in an object-oriented program is a concrete instance of a class, which acts as its blueprint. What makes each object unique, and what defines its capabilities? The answer lies within the two fundamental components you declare inside a class: **attributes** and **methods**.

Think of a blueprint for a car. It defines what every car of that model will have (like a steering wheel or engine type) and what it can do (like accelerating or braking). In programming, attributes are the ''what it has'', and methods are the ''what it can do''.

### Declaring and Understanding Class Attributes (Object Data)

**Attributes are data members that store the state or essential information about an object**. They describe the characteristics of an object. For example, a `Car` object might have attributes for its `colour`, `make`, `model`, and `year`.

When you define attributes, you''re essentially creating placeholders for the specific data that each individual object (instance) of that class will hold. These attributes represent the **state specific to each object instance**. For instance, one `Car` object might have `colour = "Red"`, while another has `colour = "Blue"`. Each object gets its own copy of these attributes in memory.

**Declaring attributes involves choosing appropriate access modifiers** to control their visibility. The most common access modifier is `private`. Declaring an attribute as `private` **restricts direct external access**, meaning only methods within that same class can directly access or modify it. This aligns with the principle of **encapsulation** and keeping the class''s public interface minimal, promoting data integrity.

For example:

```java
public class Car {
    private String colour; // An object attribute, private to this Car instance
    private String model;
    
    // ... methods will go here
}
```

You might also encounter `static` attributes. A `static` attribute creates a **single shared copy across all objects of the class**. This means all instances of that class will use and share the same memory location for that `static` attribute. This impacts memory allocation and is used for data that belongs to the class itself, rather than individual objects, such as a `companyName` shared by all `Cabbie` objects.

```java
public class Cabbie {
    private static String companyName = "Blue Cab Company"; // Shared by all Cabbie objects
    private String name; // Unique to each Cabbie object
    
    // ... methods
}
```

### Defining Class Methods (Object Behaviors)

**Methods are functions declared within a class that define the behaviours or actions an object can perform**. They encapsulate an object''s functionality. Building on our `Car` example, methods could include `startEngine()`, `accelerate()`, or `brake()`.

Methods are how objects interact and perform actions. When one object needs another object to do something, it sends a message by invoking one of its public methods.

```java
public class Car {
    private String colour;
    private String model;

    // Constructor (special method for initialising the object)
    public Car(String colour, String model) {
        this.colour = colour;
        this.model = model;
    }

    // Public method (behavior) that can be invoked by other objects
    public void startEngine() {
        System.out.println("The " + colour + " " + model + " engine is starting.");
    }

    // Private method (internal implementation detail)
    private void igniteSparkPlugs() {
        // Complex logic for ignition, hidden from external users
        System.out.println("Spark plugs ignited.");
    }
}
```

Methods can be classified as public or private. **Public methods define the services a class offers to other objects**, forming its external interface or API (Application Programming Interface). These methods should be minimal and abstract, providing functionality without exposing internal details. For example, `startEngine()` in a `Car` class provides the high-level action, but you don''t need to know the intricate internal steps.

**Private methods encapsulate internal logic and helper functions that are not intended for direct access by other classes**. They are strictly part of the class''s internal implementation, hidden from the public interface. For instance, a `turnRight()` or `turnLeft()` method might be private and called internally by a public `driveTo()` method.

A common application of public methods is providing **accessor methods, often called ''getters'' and ''setters''**, which provide controlled access to a class''s private attributes. This ensures **data integrity** and simplifies debugging, as direct external manipulation of data is prevented. For instance, a `setName()` method can include validation logic before updating a `name` attribute.

```java
public class Person {
    private String name;
    private int age;

    // Setter method with validation
    public void setName(String name) {
        if (name != null && !name.trim().isEmpty()) {
            this.name = name;
        } else {
            System.out.println("Name cannot be empty.");
        }
    }

    // Getter method
    public String getName() {
        return name;
    }

    // A public method using an internal private method
    public void introduceSelf() {
        System.out.println("Hello, my name is " + getName() + ".");
        // An internal, private helper method called by a public method
        performGreetingGesture();
    }

    private void performGreetingGesture() {
        System.out.println("(waves politely)");
    }
}
```

By carefully defining both attributes and methods, you create a robust and well-encapsulated class that accurately models a real-world concept and defines how objects of that class behave and store their state.

```mermaid
classDiagram
    class Car {
        -String colour
        -String model
        +Car(colour: String, model: String)
        +startEngine(): void
        -igniteSparkPlugs(): void
    }

    class Person {
        -String name
        -int age
        +setName(name: String): void
        +getName(): String
        +introduceSelf(): void
        -performGreetingGesture(): void
    }

    Car -- Person
```', 'Defining Class Components', 'This lesson explains that objects are made up of attributes (data) and methods (behaviors), showing how attributes store an object''s state and methods define its actions, while encapsulation via access modifiers ensures controlled interaction with the object''s data.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('8b0e0b53-1138-4984-82a0-c68171222de0', '## From Procedural to Object-Oriented Thinking

In the previous lesson, we explored the fundamentals of procedural programming, a paradigm that organises programs around sequences of instructions and functions that operate on data. Now, we embark on a crucial journey into **Object-Oriented Programming (OOP)**, a powerful paradigm that fundamentally changes how we design and build software systems. Understanding the shift from procedural to object-oriented thinking is key to grasping modern software development.

### Contrasting Procedural and Object-Oriented Paradigms

At its core, **procedural programming** focuses on **separating data from the operations that manipulate that data**. You define data structures (like arrays or structs) in one part of your program and then write functions (or procedures) in another part to process that data. Often, this means data can be global, accessible and modifiable by many different functions across the program. While this can be straightforward for smaller, simpler problems, it can lead to challenges in larger systems:

*   **Uncontrolled Access**: With global data, it''s difficult to track which function changes what data, making it prone to unintended side effects.
*   **Debugging Difficulty**: Pinpointing the source of data corruption becomes a complex task when many functions can access the same data.
*   **Modularity Issues**: Changes to data structures might necessitate widespread changes in functions that operate on that data, reducing modularity.

```mermaid
graph LR
    Data --- Function1
    Data --- Function2
    Data --- Function3
    Function1 -.-> Output
    Function2 -.-> Output
    Function3 -.-> Output
    subgraph Procedural Paradigm
        Data[Global Data/Structures]
        Function1[Function 1]
        Function2[Function 2]
        Function3[Function 3]
        Output[Result]
    end
```

**Object-Oriented Programming (OOP)** emerged as an evolutionary response to these complexities, especially for managing increasingly large and complex systems. The fundamental difference is that OOP **combines data and the operations that manipulate that data into a single entity**, known as an **object**. This core principle is called **encapsulation**.

Imagine an `Employee` system. In a procedural approach, you might have an `employee_data` structure and separate functions like `calculate_payroll()` and `update_address()`. In OOP, you would create an `Employee` object that contains both the employee''s data (attributes like `salary`, `address`) and the methods (behaviors) that act on that data (like `calculatePay()` and `updateAddress()`).

This bundling provides significant advantages:

*   **Data Integrity and Security**: By controlling access to an object''s internal data through its methods (known as **data hiding**), OOP prevents unintended direct manipulation, enhancing data integrity and security.
*   **Modularity**: Objects are self-contained, independent units. Changes to an object''s internal implementation ideally do not affect other parts of the system, as long as its public interface remains consistent.
*   **Problem-Solving Methodologies**: OOP encourages thinking about problems in terms of real-world entities and their interactions, aligning with how people naturally perceive the world. This shifts the focus from a sequence of steps to a collection of collaborating objects.

```mermaid
graph LR
    Object1[Object 1: Employee] -- Message: calculatePay() --> Object2[Object 2: Payroll System]
    subgraph Object-Oriented Paradigm
        Object1 -- Data & Behavior Encapsulated --> Object1
        Object2 -- Data & Behavior Encapsulated --> Object2
    end
```

Here''s a simplified Java example to illustrate the conceptual difference:

**Procedural-like approach (within a single method for simplicity):**

```java
public class ProceduralDataExample {
    public static void main(String[] args) {
        // Data (separated)
        String employeeName = "Alice";
        double employeeSalary = 50000.0;

        // Operation (separated)
        double annualBonus = calculateBonus(employeeSalary);
        System.out.println(employeeName + "''s annual bonus: " + annualBonus);

        // Another operation, direct manipulation of data
        employeeSalary = employeeSalary + 5000; // Direct change
        System.out.println(employeeName + "''s new salary after raise: " + employeeSalary);
    }

    public static double calculateBonus(double salary) {
        return salary * 0.10;
    }
}
```

**Object-Oriented approach:**

```java
public class ObjectOrientedDataExample {
    public static void main(String[] args) {
        // Create an Employee object (instantiation)
        Employee alice = new Employee("Alice", 50000.0);

        // Interact with the object through its methods
        System.out.println(alice.getName() + "''s annual bonus: " + alice.calculateBonus());

        // Modify data through a controlled method
        alice.giveRaise(5000.0);
        System.out.println(alice.getName() + "''s new salary after raise: " + alice.getSalary());
    }
}

class Employee {
    // Attributes (data)
    private String name;
    private double salary;

    // Constructor (to initialize the object)
    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

    // Methods (behaviors)
    public String getName() {
        return name; // Controlled access (getter)
    }

    public double getSalary() {
        return salary; // Controlled access (getter)
    }

    public double calculateBonus() {
        return this.salary * 0.10;
    }

    public void giveRaise(double amount) {
        if (amount > 0) {
            this.salary += amount; // Controlled modification (setter-like)
        }
    }
}
```

In the OOP example, the `Employee` object encapsulates both `name` and `salary` data along with the `calculateBonus()` and `giveRaise()` methods. You interact with the employee''s data *through* these methods, rather than directly modifying variables, ensuring better control and integrity.

### Differentiating Classes and Objects

At the very heart of OOP is the distinction between a **class** and an **object**. This is a foundational concept, and understanding it is vital for designing any object-oriented system.

Think of it using a simple analogy:

*   A **class is a blueprint**. It''s a template, a specification, or a definition that describes what something *is* and what it *can do*. Just like an architect''s blueprint for a house, it defines the structure, rooms, and features, but it''s not the actual house you live in.
*   An **object is an instance** of that blueprint. It''s the tangible, real-world entity built according to the class''s specifications. Following the house analogy, an object is the actual house built from the blueprint.

```mermaid
graph LR
    A[Class: Car Blueprint] --> B[Object 1: My Red Car]
    A --> C[Object 2: Taxi Cab]
    A --> D[Object 3: Delivery Van]
    B --has unique--> B_State[Color: Red, Speed: 60mph]
    C --has unique--> C_State[Color: Yellow, Speed: 45mph]
    D --has unique--> D_State[Color: White, Speed: 50mph]
```

Each **object** created from a class is a **unique, distinct instance**. While all objects of the same class share the same definition of attributes (data) and methods (behaviors), **each object maintains its own copy of those attributes**, representing its individual state.

For example, if `Car` is a class, then `myRedCar` is a specific object created from that `Car` class. `myRedCar` has its own `color` (e.g., red) and `speed` (e.g., 60 mph), distinct from another `Car` object like `taxiCab` (e.g., yellow, 45 mph). Both `myRedCar` and `taxiCab` can perform actions like `startEngine()` or `accelerate()`, as defined by the `Car` class, but they do so with their own unique state.

**Creating Objects (Instantiation)**:

The process of creating an object from a class is called **instantiation**. In many object-oriented languages like Java, this is typically done using the `new` keyword, which allocates memory for the new object and calls its constructor (a special method used to initialise the object).

Here''s a Java example to clearly demonstrate the class-object relationship:

```java
// 1. Defining a Class: The Blueprint for a Car
class Car {
    // Attributes (data) - define the state of a Car object
    String color;      // Each car object will have its own color
    String model;
    int year;

    // Constructor - a special method to initialize a new Car object
    public Car(String color, String model, int year) {
        this.color = color;
        this.model = model;
        this.year = year;
    }

    // Methods (behaviors) - define what a Car object can do
    public void startEngine() {
        System.out.println(this.color + " " + this.model + "''s engine started.");
    }

    public void accelerate() {
        System.out.println(this.color + " " + this.model + " is accelerating.");
    }

    public String getInfo() {
        return "Color: " + this.color + ", Model: " + this.model + ", Year: " + this.year;
    }
}

public class ClassAndObjectDemo {
    public static void main(String[] args) {
        // 2. Creating Objects (Instantiation) from the Car class
        // Each variable below (myCar, yourCar, taxi) is a unique object/instance of the Car class.

        Car myCar = new Car("Blue", "Sedan", 2020); // myCar is an object
        Car yourCar = new Car("Red", "SUV", 2023); // yourCar is another object
        Car taxi = new Car("Yellow", "Hatchback", 2018); // taxi is yet another object

        // 3. Interacting with Objects: Each object has its own state and can perform its own behaviors
        System.out.println("My Car Info: " + myCar.getInfo());
        myCar.startEngine();

        System.out.println("\nYour Car Info: " + yourCar.getInfo());
        yourCar.accelerate();

        System.out.println("\nTaxi Info: " + taxi.getInfo());
        taxi.startEngine();
        taxi.accelerate();

        // Even though they come from the same blueprint, they are distinct:
        System.out.println("\nAre myCar and yourCar the same object? " + (myCar == yourCar)); // Output: false
    }
}
```

In this example, `Car` is the class (blueprint), and `myCar`, `yourCar`, and `taxi` are distinct objects (instances) created from that blueprint. Each object has its own unique `color`, `model`, and `year`, and can perform `startEngine()` and `accelerate()` actions independently.', 'The Object-Oriented Shift', 'This lesson explains the shift from procedural programming, where data and functions are separate, to object-oriented programming (OOP), where classes bundle data (attributes) and behaviors (methods) into objects. It highlights key OOP concepts like encapsulation, classes vs. objects, and instantiation, showing how objects maintain their own state while interacting through defined methods.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('df259a57-6410-451f-9750-6354d522d76d', '### What is a Class?

In object-oriented programming (OOP), a **class serves as a blueprint or a template for creating objects**. Think of it like a cookie cutter: the cookie cutter itself isn''t a cookie, but it defines the shape and characteristics of all the cookies you can make with it. Similarly, a class defines the attributes (data) and behaviours (methods) that all objects instantiated from that class will possess.

When you build an object-oriented program, you''re essentially creating a collection of these objects. Therefore, understanding how to define a class is fundamental to organising your code into reusable and modular components. You **must design a class before you can create an object**.

```mermaid
classDiagram
    class Car {
        + startEngine()
        + stopEngine()
    }
```

### Defining a Class Structure

The basic syntax for declaring a class in a programming language like Java is straightforward. It begins with the `class` keyword, followed by the chosen class name, and then a block of code enclosed in curly braces (`{}`) where you define its members (attributes and methods).

For example, to define a simple `Car` class in Java, you would write:

```java
public class Car {
    // Attributes (data that describes the car)
    // Methods (actions the car can perform)
}
```

Here, `Car` is the name of our blueprint. Within the curly braces, you''ll later add details like its colour, make, model (attributes), and actions like `startEngine()` or `stopEngine()` (methods).

### Applying Class Naming Conventions

Choosing an effective name for your class is more important than it might seem. A good class name **ensures clarity and adherence to language-specific requirements**. In Java, for instance, a public class name **must match its filename for the application to compile correctly**.

Beyond technical requirements, class names should be **descriptive and clearly communicate the class''s purpose**. This improves readability and helps other developers (and your future self!) understand what the class does at a glance. While there are many naming conventions, the key is to **choose one and stick to it consistently**.

Consider these examples:

**Good Class Names:**
*   `BankAccount` (Clearly indicates it handles bank account logic)
*   `EmailService` (Suggests it provides email-related services)
*   `CustomerOrder` (Represents a customer''s order)

**Less Effective Class Names:**
*   `Utils` (Too generic; doesn''t specify its purpose)
*   `MyClass` (Lacks any descriptive information)
*   `ProcessorV2` (Doesn''t explain *what* it processes)

**Making names descriptive is a good development practice that transcends various programming paradigms**.

### Documenting Classes with Comments

Writing appropriate **comments is crucial for understanding a class''s function, its internal logic, and facilitating maintenance**. Comments clarify the purpose and behaviour of classes and their components, making your code much easier to read and debug for anyone working on it.

There are two common types of comments you''ll use in Java:

*   **Single-line comments:** These start with `//` and comment out everything until the end of that line. They are great for brief explanations or notes on specific lines of code.

    ```java
    public class Car {
        String colour; // This attribute stores the car''s colour.

        public void startEngine() {
            // Logic to start the engine goes here.
        }
    }
    ```

*   **Multi-line comments:** These start with `/*` and end with `*/`. They can span multiple lines and are ideal for more extensive explanations, block comments at the beginning of a class, or temporarily commenting out sections of code.

    ```java
    /*
     * This Car class defines the basic structure and behaviours
     * for vehicle objects in our application.
     * It includes methods for engine control and attributes
     * like colour and model.
     */
    public class Car {
        String colour; 

        public void startEngine() {
            /* This method initiates the engine startup sequence.
             * It checks fuel levels and ignition status.
             */
        }
    }
    ```

**A critical point to remember is to ensure that your multi-line comments are properly closed with `*/`**. If you miss the closing tag, the compiler might inadvertently treat subsequent lines of your code as comments, leading to unexpected errors. While thoroughly documenting your code might seem time-consuming, it''s an **investment that significantly promotes maintainability and simplifies future development**.', 'Constructing a Class Blueprint', 'This lesson explains that a class is a blueprint for creating objects, defining their attributes and methods, and emphasizes using clear naming conventions and comments to make classes readable, maintainable, and easy to understand.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('d20feaf3-2abc-418e-8986-c2d5a4b4c725', '## Unpacking Blueprints: Understanding Classes and Their Connections with UML

In the world of Object-Oriented Programming (OOP), designing clear, maintainable, and scalable systems is paramount. While code is the ultimate expression of your design, a visual representation can significantly enhance understanding, communication, and problem-solving before you even write a single line of code. This is where **Unified Modeling Language (UML) Class Diagrams** come into play. UML serves as a powerful visual tool for modeling and understanding complex class structures and their various relationships.

### Dissecting a Class: Identifying Elements in a UML Diagram

Before we dive into relationships, let''s understand the basic building block: **the class**. In a UML Class Diagram, a class is typically represented as a rectangle divided into three distinct sections:

1.  **Class Name**: The top section displays the name of the class. This name should be descriptive and clearly communicate the class''s purpose. In Java, for instance, the public class name must match its filename for compilation.
2.  **Attributes (Data)**: The middle section lists the **attributes**, which represent the data or state of the object. Attributes store essential information about an object. They are declared with appropriate access modifiers to control visibility:
    *   **`-` (minus sign)**: Denotes `private` access. Private attributes restrict direct external access, aligning with the principle of keeping the interface minimal and ensuring data integrity.
    *   **`+` (plus sign)**: Denotes `public` access. This is rarely used for attributes in good OO design, as data should be hidden.
    *   **`#` (hash sign)**: Denotes `protected` access (not explicitly used in our examples but part of UML).
    *   **`_` (underscore)**: For `static` attributes, which create a single shared copy across all objects of the class.
3.  **Methods (Behaviors)**: The bottom section lists the **methods**, which define the behaviours or actions an object can perform. Methods encapsulate an object''s functionality. Like attributes, they use access modifiers:
    *   **`-` (minus sign)**: Denotes `private` methods, encapsulating internal logic and helper functions not intended for direct access by other classes.
    *   **`+` (plus sign)**: Denotes `public` methods, defining the services a class offers to other objects, representing its external API. These are part of the class''s interface.

Let''s look at a simple `Person` class example:

```java
public class Person {
    // Attributes (private by convention for data hiding)
    private String name;     // Stores the person''s name
    private String address;  // Stores the person''s address

    // Constructor
    public Person(String name, String address) {
        this.name = name;
        this.address = address;
    }

    // Public Methods (Accessors/Getters and Setters)
    public String getName() { // Provides controlled access to ''name''
        return name;
    }

    public void setName(String newName) { // Allows controlled modification of ''name''
        this.name = newName;
    }

    public String getAddress() { // Provides controlled access to ''address''
        return address;
    }

    public void setAddress(String newAddress) { // Allows controlled modification of ''address''
        this.address = newAddress;
    }

    // Private internal method (implementation detail)
    private void updateInternalRecord() {
        System.out.println("Updating internal record for " + name);
    }
}
```

And its corresponding UML Class Diagram:

```mermaid
classDiagram
    class Person {
        -name: String
        -address: String
        +Person(name: String, address: String)
        +getName(): String
        +setName(newName: String): void
        +getAddress(): String
        +setAddress(newAddress: String): void
        -updateInternalRecord(): void
    }
```

### Navigating Object Interactions: Interpreting Relationships Between Classes

Once individual classes are defined, UML Class Diagrams truly shine by illustrating **how these classes interact and relate to each other**. Understanding these relationships—**association, aggregation, composition, and inheritance**—is crucial for modeling complex systems.

#### 1. Inheritance: The ''Is-a'' Relationship

**Inheritance** is a fundamental OOP concept where a new class (subclass) derives properties and behaviours from an existing class (superclass). This relationship is often referred to as an **`is-a` relationship**, meaning the subclass is a more specific type of its superclass. For example, a `Dog` **`is an`** `Animal`.

**UML Notation**: A solid line with an **unfilled triangle** (closed, hollow arrowhead) pointing from the subclass to the superclass.

**Example**: Consider an `Animal` class with a `makeSound()` method, and `Dog` and `Cat` classes that inherit from `Animal`.

```java
// Superclass
public class Animal {
    private String species;

    public Animal(String species) {
        this.species = species;
    }

    public void eat() {
        System.out.println(species + " is eating.");
    }

    public void makeSound() {
        System.out.println(species + " makes a sound.");
    }
}

// Subclass extending Animal
public class Dog extends Animal {
    public Dog() {
        super("Dog");
    }

    @Override
    public void makeSound() {
        System.out.println("Woof! Woof!");
    }
}

// Another subclass extending Animal
public class Cat extends Animal {
    public Cat() {
        super("Cat");
    }

    @Override
    public void makeSound() {
        System.out.println("Meow!");
    }
}

public class Zoo {
    public static void main(String[] args) {
        Dog myDog = new Dog();
        Cat myCat = new Cat();

        myDog.eat();
        myDog.makeSound();

        myCat.eat();
        myCat.makeSound();
    }
}
```

**UML Diagram for Inheritance**:

```mermaid
classDiagram
    Animal <|-- Dog
    Animal <|-- Cat
    Animal : +species
    Animal : +eat()
    Animal : +makeSound()
    Dog : +makeSound()
    Cat : +makeSound()
```

#### 2. Composition: The ''Has-a'' Relationship (Strong Ownership)

**Composition** is a strong form of a **`has-a` relationship** where one class (the ''whole'' or container) contains instances of other classes (the ''parts'') as its members. The key characteristic is that the **parts cannot exist independently** of the whole; if the whole is destroyed, the parts are also destroyed. Think of a `Car` **`has an`** `Engine`. An `Engine` object''s lifecycle is managed by the `Car` object; without the `Car`, the specific `Engine` instance often ceases to exist in that context.

**UML Notation**: A solid line with a **filled diamond** (black diamond) on the ''whole'' or container class side, pointing to the ''part'' class.

**Example**: A `Car` and its `Engine`. If the `Car` is scrapped, its `Engine` (as part of that specific car) is also considered scrapped, not reused independently in this strong composition model.

```java
// The ''part'' class
public class Engine {
    private String type;

    public Engine(String type) {
        this.type = type;
        System.out.println(type + " Engine created.");
    }

    public void start() {
        System.out.println(type + " Engine starting.");
    }

    public void stop() {
        System.out.println(type + " Engine stopping.");
    }
}

// The ''whole'' class using composition
public class Car {
    private String make;
    private Engine engine; // Car ''has an'' Engine (composition)

    public Car(String make, String engineType) {
        this.make = make;
        // Engine is created when Car is created, tightly bound
        this.engine = new Engine(engineType);
        System.out.println(make + " Car created with its engine.");
    }

    public void drive() {
        System.out.println(make + " Car is driving.");
        engine.start(); // Car delegates engine functionality
    }

    // Imagine a destructor or close method that would also dispose of the engine
    public void dispose() {
        engine.stop();
        System.out.println(make + " Car disposed. Engine also disposed.");
        this.engine = null; // Indicate engine is no longer accessible
    }

    public static void main(String[] args) {
        Car myCar = new Car("Honda", "V4");
        myCar.drive();
        myCar.dispose();
    }
}
```

**UML Diagram for Composition**:

```mermaid
classDiagram
    Car "1" *-- "1" Engine : contains
    Car : +make
    Car : +drive()
    Engine : +type
    Engine : +start()
    Engine : +stop()
```

#### 3. Aggregation: The ''Has-a'' Relationship (Weak Ownership)

**Aggregation** is a weaker form of a **`has-a` relationship** compared to composition. Here, the ''part'' object can **exist independently** of the ''whole'' or container object. While the whole `has a` part, the part''s lifecycle is not necessarily tied to the whole. If the whole is destroyed, the part might continue to exist.

**UML Notation**: A solid line with an **unfilled diamond** (hollow diamond) on the ''whole'' or container class side, pointing to the ''part'' class.

**Example**: A `Department` `has many` `Professor`s. A `Professor` can exist (e.g., move to another department, or be retired) even if a `Department` is dissolved.

```java
// The ''part'' class, which can exist independently
public class Professor {
    private String name;

    public Professor(String name) {
        this.name = name;
        System.out.println("Professor " + name + " is ready.");
    }

    public void teach() {
        System.out.println(name + " is teaching.");
    }
}

// The ''whole'' class using aggregation
import java.util.ArrayList;
import java.util.List;

public class Department {
    private String name;
    private List<Professor> professors; // Department ''has many'' Professors (aggregation)

    public Department(String name) {
        this.name = name;
        this.professors = new ArrayList<>();
        System.out.println(name + " Department created.");
    }

    public void addProfessor(Professor prof) {
        this.professors.add(prof);
        System.out.println(prof.getName() + " added to " + name + ".");
    }

    public void describe() {
        System.out.println("Department: " + name);
        System.out.println("Professors:");
        for (Professor prof : professors) {
            prof.teach();
        }
    }

    public static void main(String[] args) {
        Professor profSmith = new Professor("Dr. Smith");
        Professor profJones = new Professor("Dr. Jones");

        Department csDept = new Department("Computer Science");
        csDept.addProfessor(profSmith);
        csDept.addProfessor(profJones);

        csDept.describe();

        // Even if csDept is ''dissolved'', profSmith and profJones still exist
        // They could join other departments or become independent consultants
    }
}
```

**UML Diagram for Aggregation**:

```mermaid
classDiagram
    Department "1" o-- "*" Professor : employs
    Department : +name
    Department : +addProfessor()
    Professor : +name
    Professor : +teach()
```

#### 4. Association: The General Relationship

**Association** is the most general `has-a` relationship, representing a connection or interaction between objects where neither is necessarily a ''part-of'' the other. It often signifies one object *using the services* of another, or a less strict relationship than aggregation.

**UML Notation**: A simple solid line between classes. Multiplicity (cardinality) can also be added.

**Example**: A `Computer` uses a `Keyboard` and a `Monitor`. These components are separate and independent, but they interact for the system to function.

```java
// Independent classes that interact
public class Keyboard {
    public void type() {
        System.out.println("Typing on the keyboard.");
    }
}

public class Monitor {
    public void display() {
        System.out.println("Displaying visuals on the monitor.");
    }
}

public class Computer {
    private Keyboard keyboard;
    private Monitor monitor;

    public Computer(Keyboard keyboard, Monitor monitor) {
        this.keyboard = keyboard; // Computer uses existing Keyboard
        this.monitor = monitor;   // Computer uses existing Monitor
        System.out.println("Computer assembled.");
    }

    public void startSystem() {
        System.out.println("Computer starting...");
        keyboard.type();   // Delegates action to Keyboard
        monitor.display(); // Delegates action to Monitor
    }

    public static void main(String[] args) {
        Keyboard usbKeyboard = new Keyboard();
        Monitor hdMonitor = new Monitor();

        Computer desktop = new Computer(usbKeyboard, hdMonitor);
        desktop.startSystem();

        // Keyboard and Monitor can exist and be used with other computers
        // or even independently for testing.
    }
}
```

**UML Diagram for Association**:

```mermaid
classDiagram
    Computer "1" -- "1" Keyboard : uses
    Computer "1" -- "1" Monitor : uses
    Computer : +startSystem()
    Keyboard : +type()
    Monitor : +display()
```

#### 5. Cardinality (Multiplicity) in UML Diagrams

**Cardinality**, also known as multiplicity, specifies **how many objects participate in a relationship** and whether that participation is optional or mandatory. This is typically indicated near the ends of the relationship line in a UML diagram.

Common Cardinality Notations:

*   **`1`**: Exactly one instance.
*   **`0..1`**: Zero or one instance (optional).
*   **`*` or `0..*`**: Zero or more instances (many/unlimited).
*   **`1..*`**: One or more instances.
*   **`n`**: Exactly `n` instances (e.g., `2`, `5`).
*   **`m..n`**: A range of instances, from `m` to `n` (e.g., `2..5`).

**Example**: An `Employee` `has-a` `Division` (mandatory, one), `has-many` `JobDescription`s (mandatory, one or more), `has-a` `Spouse` (optional, zero or one), and `has-many` `Child`ren (optional, zero or more).

```java
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

public class Employee {
    private String name;
    private Division division;            // Mandatory, 1
    private List<JobDescription> jobDescriptions; // Mandatory, 1..*
    private Spouse spouse;                // Optional, 0..1
    private List<Child> children;         // Optional, 0..*

    public Employee(String name, Division division, JobDescription initialJob) {
        this.name = name;
        this.division = division;
        this.jobDescriptions = new ArrayList<>();
        this.jobDescriptions.add(initialJob);
        this.children = new ArrayList<>();
    }

    public void setSpouse(Spouse spouse) {
        this.spouse = spouse;
    }

    public void addChild(Child child) {
        this.children.add(child);
    }

    // ... other methods ...

    public static void main(String[] args) {
        Division hr = new Division("HR");
        JobDescription analyst = new JobDescription("Analyst");

        Employee alice = new Employee("Alice", hr, analyst);

        Spouse bob = new Spouse("Bob", new Date());
        alice.setSpouse(bob);

        Child charlie = new Child("Charlie");
        alice.addChild(charlie);

        Child diana = new Child("Diana");
        alice.addChild(diana);

        // An employee without a spouse or children is also valid
        Employee carol = new Employee("Carol", hr, analyst);

        System.out.println(alice.name + " works in " + alice.division.getName());
        if (alice.spouse != null) {
            System.out.println(alice.name + " is married to " + alice.spouse.getName());
        }
        System.out.println(alice.name + " has " + alice.children.size() + " children.");
    }
}

class Division {
    private String name;
    public Division(String name) { this.name = name; }
    public String getName() { return name; }
}

class JobDescription {
    private String title;
    public JobDescription(String title) { this.title = title; }
    public String getTitle() { return title; }
}

class Spouse {
    private String name;
    private Date anniversaryDate;
    public Spouse(String name, Date date) { this.name = name; this.anniversaryDate = date; }
    public String getName() { return name; }
}

class Child {
    private String name;
    public Child(String name) { this.name = name; }
    public String getName() { return name; }
}
```

**UML Diagram for Cardinality**:

```mermaid
classDiagram
    Employee "1" -- "1" Division : works_in
    Employee "1" -- "1..*" JobDescription : has_job
    Employee "1" -- "0..1" Spouse : married_to
    Employee "1" -- "0..*" Child : has_child

    Employee : +name
    Division : +name
    JobDescription : +title
    Spouse : +name
    Child : +name
```


UML Class Diagrams are an invaluable tool for any software developer. By mastering the ability to identify class elements and interpret their relationships, you gain a clearer understanding of object-oriented design, allowing you to build more robust, maintainable, and scalable systems.', 'UML for Class Relationships: Visualizing Object-Oriented Designs', 'This lesson is about understanding classes and their relationships using UML Class Diagrams. It explains how to represent class attributes and methods, and how to model inheritance, composition, aggregation, association, and cardinality to visualize and design clear, maintainable, and scalable object-oriented systems.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('20b3450a-baaa-413d-b7ea-c598874439f8', 'Welcome to this lesson on **Designing Effective Public Interfaces**. In object-oriented programming, how you expose your classes to the outside world is paramount. A well-designed public interface is key to creating **modular, maintainable, and robust software**.

## What is a Public Interface?

The **public interface** of a class defines the **services it offers to other objects**, essentially acting as its external Application Programming Interface (API). Think of it as the control panel for your class. When designing this interface, the primary goal is to provide the **absolute minimal user interface possible**. This means exposing only the functionality that other developers or client code absolutely need to interact with your class, without revealing the complex internal workings.

This principle aligns with the core concept of **abstraction**, focusing on *what* a class does rather than *how* it does it. For example, when you drive a car, you interact with its public interface: the steering wheel, accelerator, and brake pedal. You don''t need to know the intricate details of the engine or transmission (the implementation) to operate the vehicle effectively. A well-designed interface ensures that changes to the car''s engine (implementation) don''t require you to relearn how to drive (interface), as long as the external performance remains consistent.

```mermaid
graph TD
    A[Client Code] --> |Uses| B(Public Interface)
    B --> |Invokes Internal Logic| C{Implementation Details}
    C --> |Results| B
    B --> |Provides Services| A
```

In Java, public methods and constructors typically form the public interface. Here''s a simple `Car` class illustrating its public interface:

```java
public class Car {
    // Public Constructor: Part of the interface for object creation
    public Car(String model, String make) { // Public interface: how a Car object is created
        System.out.println("Creating a " + make + " " + model);
        // ... internal initialisation logic
    }

    // Public Method: Part of the public interface (service offered)
    public void startEngine() { // Public interface: how to start the car
        System.out.println("Engine started.");
        // ... internal engine starting sequence
    }

    // Public Method: Part of the public interface (service offered)
    public void accelerate(int speedIncrease) { // Public interface: how to make the car go faster
        System.out.println("Accelerating by " + speedIncrease + " mph.");
        // ... internal acceleration logic
    }

    // Public Method: Part of the public interface (service offered)
    public void brake() { // Public interface: how to stop the car
        System.2ed95544-8955-4b79-abda-d09f8d9499d1("Braking.");
        // ... internal braking mechanism
    }

    // ... other public methods ...
}
```

## Designing Minimal Public Interfaces

Building upon the concept of a public interface, it is **crucial to provide the absolute minimal user interface** for a class. This means exposing **only what external users absolutely need** to interact with it. Every public method or attribute beyond this minimum increases the complexity for users and can lead to unnecessary coupling.

Why is minimality so important?

*   **Simplifies Class Usage**: A smaller interface is easier to learn, understand, and use, reducing the cognitive load on developers.
*   **Enhances Security**: By controlling access to sensitive data and operations, you can prevent unintended or malicious manipulation. All attributes, for instance, should generally be declared as `private`.
*   **Prevents Unnecessary Coupling**: When client code depends on fewer public methods, it becomes less rigid and fragile. Changes to hidden internal details are less likely to break external code.

The process of designing a minimal interface is often **iterative**. You should start by defining only the most essential public methods. As you gather requirements and receive feedback from users (who could be other developers or even other objects within the system), you can iteratively add more interfaces only when they are explicitly required. This approach ensures that your class serves its purpose effectively without overexposing its capabilities.

## Implementing Private Class Methods

While public methods form the interface, **private methods are strictly part of a class''s internal implementation**. They encapsulate **internal logic and helper functions that are not intended for direct access by other classes**. They are entirely hidden from the public interface, promoting **data hiding** and **encapsulation**.

Consider a `Cabbie` class. A public method like `giveDestination()` might internally call private methods to manage the route, such as `turnRight()` or `turnLeft()`. The user of the `Cabbie` object doesn''t need to know *how* the cabbie navigates, only that they can specify a destination.

Here''s an example using a `Driver` class, which might have a public method that relies on private helper methods:

```java
public class Driver {
    private String currentRoute;
    private int fuelLevel;

    // Private helper method: internal logic, not exposed externally
    private void calculateOptimalRoute(String destination) {
        // Complex algorithm to find the best route
        this.currentRoute = "Route to " + destination + ": Via Main St, then Oak Ave";
        System.out.println("Internal: Optimal route calculated.");
    }

    // Private helper method: manages internal state, not directly accessible
    private void consumeFuel(int distance) {
        this.fuelLevel -= (distance / 10); // Simplified fuel consumption
        System.out.println("Internal: Consumed fuel for " + distance + " miles. Fuel left: " + this.fuelLevel);
    }

    // Public method: part of the class''s interface
    public void driveTo(String destination) {
        System.out.println("Driver is preparing to drive to " + destination);
        calculateOptimalRoute(destination); // Internal call to private method
        int estimatedDistance = 50; // Placeholder for actual distance from route calculation
        consumeFuel(estimatedDistance); // Internal call to private method
        System.out.println("Driving along: " + this.currentRoute);
        System.out.println("Arrived at " + destination + ".");
    }

    // Public method: to check fuel externally, part of the public interface
    public int getFuelLevel() {
        return this.fuelLevel;
    }

    // Constructor
    public Driver() {
        this.fuelLevel = 100; // Initial fuel
        System.out.println("Driver created with full tank.");
    }
}
```

In this `Driver` class, `calculateOptimalRoute()` and `consumeFuel()` are private. They handle the complex, internal details of navigation and fuel management. The user of the `Driver` object simply calls `driveTo()`, and the `Driver` class handles the *how* using its private methods, without exposing those intricate steps. This robust separation of interface and implementation is a hallmark of good object-oriented design.', 'Designing Effective Public Interfaces', 'This lesson explains that a public interface defines the services a class exposes to the outside world, showing what a class does without revealing how it works. By keeping the interface minimal and using private methods for internal logic, you make your classes easier to use, maintain, and extend while promoting encapsulation and reducing coupling.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('fbc5a89e-8d85-4408-87c9-ed75e2e13e53', '# Introduction to Inheritance: Building Hierarchies in OOP

In the realm of Object-Oriented Programming (OOP), one of the most powerful concepts for building reusable and organised code is **inheritance**. It''s a fundamental construct that allows for the creation of sophisticated class relationships and is central to how we design robust software systems.

## What is Inheritance?

At its core, **inheritance** is a mechanism where a **new class, known as a subclass**, derives properties and behaviours from an **existing class, called a superclass**. Think of it like a family tree in programming: a child inherits certain traits from its parent. This concept is vital for **code reusability** and for establishing **hierarchical relationships between classes**. Instead of writing the same code multiple times, we can define common characteristics once and have other classes reuse them.

For instance, if you have a `Vehicle` class, you wouldn''t want to re-define `speed`, `colour`, and `startEngine()` methods for every type of vehicle like `Car` or `Motorcycle`. Inheritance allows `Car` and `Motorcycle` to simply *inherit* these common features from `Vehicle`.

## Superclasses and Subclasses

To understand inheritance, it''s crucial to differentiate between the two main roles in this hierarchy:

*   **Superclass (Parent Class / Base Class)**: This is the existing class from which other classes inherit. It contains all the attributes (data) and behaviours (methods) that are common to the classes that will inherit from it. For example, in a hierarchy involving animals, `Mammal` would be a superclass because all mammals share certain traits like having hair and generating internal heat.

*   **Subclass (Child Class / Derived Class)**: This is the new class that **extends** the superclass. A subclass automatically gets access to the public and protected attributes and methods of its superclass, and it can also add its own unique attributes and behaviours. If `Dog` inherits from `Mammal`, then `Dog` is the subclass, extending the general concept of a mammal to a more specific type.

In Java, the `extends` keyword is used to establish this inheritance relationship.

Let''s look at an example using a `Mammal` superclass and a `Dog` subclass:

```java
class Mammal {
    String eyeColor;
    
    public void generateInternalHeat() {
        System.out.println("Mammal is generating internal heat.");
    }

    public String getEyeColor() {
        return eyeColor;
    }

    public void setEyeColor(String color) {
        this.eyeColor = color;
    }
}

class Dog extends Mammal {
    String breed;

    public void bark() {
        System.out.println("Dog barks: Woof!");
    }

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public static void main(String[] args) {
        Dog myDog = new Dog();
        myDog.setEyeColor("Brown"); // Inherited from Mammal
        myDog.generateInternalHeat(); // Inherited from Mammal
        myDog.setBreed("Golden Retriever");
        myDog.bark(); // Specific to Dog

        System.out.println("My dog''s eye color: " + myDog.getEyeColor());
        System.out.println("My dog''s breed: " + myDog.getBreed());
    }
}
```

In this code, `Dog` **extends** `Mammal`, meaning `Dog` inherits `eyeColor`, `generateInternalHeat()`, and `getEyeColor()`/`setEyeColor()` methods directly from `Mammal`. It then adds its own `breed` attribute and `bark()` method, making it a more specific type of `Mammal`.

## The "Is-a" Relationship

Inheritance conceptually models the **"is-a" relationship**. This is a crucial principle for correctly applying inheritance and designing logical class hierarchies. It signifies that a subclass **"is a type of"** its superclass. When a subclass inherits from a superclass, it means the subclass can do anything that the superclass can do, plus its own specific actions.

For example:

*   **A `Car` is a `Vehicle`**.
*   **A `Dog` is a `Mammal`**.
*   **A `Circle` is a `Shape`**.

If you can confidently state that object A "is a" object B, then an inheritance relationship is usually appropriate. This simple rule helps ensure that your class hierarchies are logically sound and that the derived class truly specialises the base class''s functionality.

Here''s a visual representation of a simple inheritance hierarchy:

```mermaid
classDiagram
    Animal <|-- Dog
    Animal <|-- Cat

    class Animal {
        +String species
        +void makeSound()
    }

    class Dog {
        +String breed
        +void bark()
    }

    class Cat {
        +String furColor
        +void meow()
    }
```

In this diagram, both `Dog` and `Cat` are types of `Animal`, illustrating the fundamental "is-a" relationship. They inherit common characteristics from `Animal` and then define their unique behaviours. This foundational understanding of inheritance, superclasses, subclasses, and the "is-a" relationship is essential for building scalable and maintainable object-oriented applications.', 'Introduction to Inheritance: Building Hierarchies in OOP', 'This lesson introduces inheritance in object-oriented programming, showing how a subclass can inherit attributes and methods from a superclass. It explains the “is-a” relationship, emphasizes code reuse, and demonstrates creating hierarchical class structures. Examples with `Mammal` and `Dog` illustrate how subclasses extend superclasses while adding their own unique behaviours, forming the foundation for scalable and maintainable OOP designs.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('f6fedc4e-809f-4e68-a478-c6597593b6b6', '# Building Resilient Software: A Guide to Exception Handling

In the world of programming, our applications don''t always run as smoothly as we''d like. Sometimes, unexpected events occur during program execution that can disrupt the entire flow, leading to crashes or unstable behaviour. These are known as **runtime errors**, and managing them effectively is crucial for building robust and reliable software systems.

## What are Runtime Errors?

Imagine your program trying to divide a number by zero, or attempting to open a file that doesn''t exist. These actions, while seemingly straightforward in code, can lead to unexpected problems when the program is actually running. In procedural programming, such errors might cause the entire application to crash abruptly, leaving users frustrated and data potentially corrupted.

**Object-oriented languages, however, offer sophisticated mechanisms to detect and handle these unexpected events gracefully: exceptions**. Proper exception handling is key to preventing application crashes and enabling error recovery or graceful exits, thereby ensuring overall system stability.

## Introducing `try/catch` Blocks

The cornerstone of exception handling in object-oriented languages is the **`try/catch` block**. This construct allows programmers to designate sections of code that might produce an error (the `try` block) and then define specific responses if those errors occur (the `catch` block).

Consider a scenario where we want to perform a division. We know that division by zero is mathematically undefined and will cause a runtime error. Here''s how we might handle it in Java:

```java
public class DivisionExample {
    public static void main(String[] args) {
        int numerator = 10;
        int denominator = 0;
        int result;

        try {
            // This block contains code that might throw an exception
            result = numerator / denominator; // This will cause an ArithmeticException
            System.out.println("Result: " + result);
        } catch (ArithmeticException e) {
            // This block executes if an ArithmeticException occurs within the try block
            System.out.println("Error: Cannot divide by zero. Please provide a non-zero denominator.");
            System.out.println("Exception message: " + e.getMessage());
            result = 0; // Assign a default or safe value
        }

        System.out.println("Program continues after exception handling. Final result: " + result);
    }
}
```

In this example, the line `result = numerator / denominator;` is placed within the `try` block because it''s a potential source of an `ArithmeticException`. When this exception occurs, the execution of the `try` block **is immediately terminated**. The program then looks for a matching `catch` clause. In this case, `catch (ArithmeticException e)` matches, and the code within that block is executed, providing a user-friendly error message and assigning a default value to `result`. After the `catch` block finishes, the program **resumes execution with the statement immediately following the `try/catch` block**.

## The Flow of Exception Handling

Understanding the flow is critical. When an exception is thrown:

1.  **Execution of the `try` block halts**: Any code remaining in the `try` block after the exception is thrown is skipped.
2.  **`catch` clauses are evaluated**: The system checks if any `catch` clause explicitly handles the type of exception that was thrown.
3.  **Matching `catch` block executes**: If a match is found, the code within that `catch` block runs.
4.  **Execution resumes**: Once the `catch` block completes, the program proceeds with the code immediately following the entire `try/catch` construct.
5.  **Uncaught exceptions**: If no `catch` clause matches the thrown exception, it propagates up the call stack to higher-level `try` blocks. If it reaches the top level and is still not caught, the system''s default handler will take over, typically leading to program termination (a crash).

Here’s a simplified visual of the process:

```mermaid
graph TD
    A[Start Program]
    B{Code in Try Block}
    C{Exception Occurs?}
    D[Execute Catch Block]
    E[Continue After Try/Catch]
    F[No Matching Catch / Uncaught]
    G[Program Crash]

    A --> B
    B --> C
    C -- Yes --> D
    C -- No --> E
    D --> E
    D -- No Matching Catch --> F
    F --> G
```

## Catching Specific vs. General Exceptions

As seen, you can specify the exact type of exception to catch, like `ArithmeticException`. This allows for highly tailored error responses. However, you can also use a more general `Exception` type in your `catch` block to **catch any exception that might occur**. While useful for broad error trapping, it''s generally good practice to catch more specific exceptions where possible, as it allows for more precise handling and debugging.

```java
public class GenericExceptionExample {
    public static void main(String[] args) {
        try {
            // Some potentially ''nasty code'' that could throw various exceptions
            String text = null;
            System.out.println(text.length()); // This will throw a NullPointerException

            int[] numbers = {1, 2, 3};
            System.out.println(numbers); // This will throw an ArrayIndexOutOfBoundsException
        } catch (Exception e) {
            // This catch block will handle ANY type of exception
            System.out.println("An unexpected error occurred: " + e.getMessage());
            e.printStackTrace(); // Prints the stack trace for debugging purposes
        }
    }
}
```

## Why Exception Handling Matters

Designing proper error handling into your classes and applications from the very start is paramount. Ignoring potential problems is a "recipe for disaster", as it can lead to application instability or even corrupted data. While simply aborting a program gracefully is better than a crash, the true power of exceptions lies in their ability to facilitate **error recovery**. Instead of just shutting down, your application can attempt to fix the problem, prompt the user for correct input, or log the error for later analysis, ensuring the system remains stable and responsive.

By leveraging exceptions, you contribute to creating "bulletproof code" that can anticipate and react to unforeseen circumstances, making your software more resilient and user-friendly.', 'Building Resilient Software: A Guide to Exception Handling', 'This lesson covers exception handling in object-oriented programming. It explains how runtime errors can disrupt programs and shows how `try/catch` blocks allow graceful error detection and recovery. Catching specific or general exceptions helps prevent crashes, maintain data integrity, and enable user-friendly error handling, making software more robust, resilient, and maintainable.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('dcccc6fc-222e-4ecd-be3a-068acc1201f7', '## Introduction to Procedural Programming

Before the widespread adoption of object-oriented programming (OOP), **procedural programming** was, and in many domains still is, a dominant paradigm for developing software. It structures programs around procedures (also known as functions or subroutines) that carry out computations. Unlike OOP, where data and the operations on that data are bundled together, procedural programming fundamentally **separates data from the operations that act upon it**. Understanding this paradigm provides a crucial contrast for comprehending the design philosophies behind object-oriented systems.

The core tenets of procedural programming can be distilled into a few key characteristics:

*   **Sequential Execution**: Programs typically execute instructions step-by-step, from top to bottom, in a predefined order. This means that the flow of control is explicit and follows a logical sequence.
*   **Reliance on Functions (Procedures/Subroutines)**: Functionality is organised into discrete units called functions. These functions perform specific tasks and can be called from various parts of the program, promoting code reuse.
*   **Separation of Data and Operations**: Data structures are often defined independently of the functions that manipulate them. Data might reside in global areas, accessible by multiple functions, or be passed explicitly between functions.

Procedural programming is built upon three basic constructs:
*   **Sequence**: Instructions are executed one after another.
*   **Conditions**: `if-statements` allow different blocks of code to execute based on whether a condition is true or false.
*   **Iterations (Loops)**: `loops` allow a block of code to be repeated multiple times.

Here’s a basic illustration of how data and functions interact in a procedural paradigm:

```mermaid
graph TD
    A[Global Data] --> B[Function 1]
    A --> C[Function 2]
    A --> D[Function 3]
    B --> E[Output]
    C --> E
    D --> E
```
This diagram depicts global data being accessed and manipulated by separate functions, which then produce an output.

## Identifying and Utilizing Functions in Procedural Programming

**Functions** are the workhorses of procedural programming. They are self-contained blocks of code designed to perform a specific task, often taking inputs (parameters) and producing outputs (return types).

**Defining a Function**:
When you define a function, you specify its name, the type and number of parameters it expects, and the type of value it will return (if any). This allows you to encapsulate a specific piece of logic, making your code more modular and easier to understand.

Consider this simple Java example (though Java is OOP, methods can represent procedural functions for illustration):

```java
public class ProceduralExample {

    // Function definition: ''add'' takes two integers and returns their sum.
    public static int add(int a, int b) { // ''a'' and ''b'' are parameters
        return a + b; // Returns an integer
    }

    // Function definition: ''greet'' takes a string and prints a greeting.
    public static void greet(String name) { // ''name'' is a parameter
        System.out.println("Hello, " + name + "!"); // No return value (void)
    }

    public static void main(String[] args) {
        // Invoking the ''add'' function
        int sum = add(5, 3); // 5 and 3 are arguments passed to parameters ''a'' and ''b''
        System.out.println("Sum: " + sum); // Output: Sum: 8

        // Invoking the ''greet'' function
        greet("Alice"); // "Alice" is an argument passed to parameter ''name''
        // Output: Hello, Alice!
    }
}
```
In this example, `add` and `greet` are functions. The `main` method demonstrates **how to invoke** these functions by passing **arguments** that correspond to their defined **parameters**.

## Understanding Data Handling in Procedural Programming

A critical aspect of procedural programming is how data is managed, particularly the distinction between **global** and **local variables**, and the mechanism of **parameter passing**. Proper understanding of these concepts is essential for controlling data access and flow within your program, which in turn helps prevent unintended side effects.

*   **Global Variables**: These variables are declared outside of any function and are accessible from anywhere within the program. While convenient for broad access, they pose significant challenges:
    *   **Uncontrolled Access**: Multiple functions can directly modify global data, making it difficult to track changes and predict program behaviour.
    *   **Debugging Difficulty**: When a bug related to data corruption occurs, it''s challenging to pinpoint which function caused the issue due to widespread access.
    *   **Lack of Integrity**: Without control over who accesses or modifies data, its integrity can be compromised.

*   **Local Variables**: These variables are declared within a specific function (or block of code) and are only accessible within that scope. When the function finishes execution, the local variables are removed from memory. This limits their impact, making code easier to manage and debug within that specific function.

*   **Parameter Passing**: Instead of relying solely on global variables, data can be explicitly passed to functions as parameters. This mechanism ensures that a function operates only on the data it receives, giving it controlled access and reducing unexpected side effects.

Here''s a Java example illustrating global (static fields in a class, serving a similar purpose for illustration) versus local variables and parameter passing:

```java
public class DataHandlingExample {

    // This acts as a ''global'' variable for demonstration purposes in a class context
    // In strict procedural, it would be outside any function block at the top level.
    static int globalCounter = 0; // A ''global'' variable

    public static void incrementGlobal() {
        // Directly modifies the ''globalCounter''
        globalCounter++;
        System.out.println("Global counter (inside incrementGlobal): " + globalCounter);
    }

    public static void processLocalAndParameter(int valueFromMain) { // ''valueFromMain'' is a parameter
        int localVariable = 10; // ''localVariable'' is a local variable
        System.out.println("Local variable: " + localVariable);
        System.out.println("Value from main (parameter): " + valueFromMain);

        // Modifying a local variable and the parameter (copy in Java)
        localVariable += 5;
        valueFromMain *= 2; // This change only affects the copy of ''valueFromMain'' within this function
        System.out.println("Local variable after modification: " + localVariable);
        System.out.println("Value from main (parameter) after modification: " + valueFromMain);
    }

    public static void main(String[] args) {
        System.out.println("Initial global counter: " + globalCounter); // Output: 0

        incrementGlobal(); // Increments globalCounter
        System.out.println("Global counter (after incrementGlobal call): " + globalCounter); // Output: 1

        int myValue = 20;
        System.out.println("\nCalling processLocalAndParameter with myValue: " + myValue); // Output: 20
        processLocalAndParameter(myValue); // Pass ''myValue'' as an argument
        System.out.println("myValue after processLocalAndParameter call: " + myValue); // Output: 20 (original ''myValue'' unchanged)

        // Demonstrates that ''localVariable'' is out of scope here
        // System.out.println(localVariable); // This would cause a compile error
    }
}
```
In this example, `globalCounter` is shared and can be directly modified by `incrementGlobal()`. However, `localVariable` is confined to `processLocalAndParameter()`, and changes to `valueFromMain` inside `processLocalAndParameter()` do not affect the original `myValue` in `main()`, illustrating controlled data flow through parameter passing.

By grasping these fundamental principles of procedural programming, you establish a solid foundation for understanding how later paradigms, especially object-oriented programming, evolved to address some of its inherent complexities and limitations.', 'Core Programming Paradigms', 'This lesson introduces procedural programming, where programs are structured around sequences of instructions and functions that operate on separate data. It explains key concepts like global vs. local variables, parameter passing, and function usage, highlighting how data and operations are kept separate—a contrast that sets the stage for understanding object-oriented programming.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('a51e1cf9-daab-42f7-8b65-754de29300b5', '### Objects in Motion: Methods, Messages, and Flexible Creation

In the world of object-oriented programming, classes provide the blueprints, and objects are the living, breathing instances. But what good is an object if it can''t *do* anything or *talk* to other objects? This lesson explores how objects perform actions through methods, communicate by sending messages, and how they can be flexibly initialised using multiple constructors.

### Invoking Object Methods

Every object created from a class possesses its own **attributes** (data) and **behaviors** (methods). Methods are the actions or operations that an object can perform. For instance, a `Car` object might have methods like `startEngine()` or `accelerate()`. To make an object perform one of its defined behaviors, you **invoke** (or call) its method.

The basic syntax for invoking a method on an instantiated object is straightforward: you use the object''s name, followed by a dot (`.`), and then the method name, along with any necessary arguments in parentheses.

Consider our `Car` class from a previous lesson, now with some methods:

```java
public class Car {
    String colour; // Attribute
    String model;  // Attribute

    public Car(String colour, String model) {
        this.colour = colour;
        this.model = model;
    }

    // Method to start the engine
    public void startEngine() {
        System.out.println("The " + colour + " " + model + " engine is starting.");
    }

    // Method to display car info
    public void displayInfo() {
        System.out.println("This car is a " + colour + " " + model + ".");
    }
}

public class Showroom {
    public static void main(String[] args) {
        // Instantiate a Car object
        Car myCar = new Car("Blue", "SUV");

        // Invoking object methods
        myCar.displayInfo(); // Calls the displayInfo() method on myCar
        myCar.startEngine(); // Calls the startEngine() method on myCar
    }
}
```

In this example, `myCar.displayInfo()` and `myCar.startEngine()` are direct invocations of methods on the `myCar` object. Correctly invoking methods is **key to making objects perform actions and interact within your program**.

### Understanding Message Sending in OOP

When you invoke a method on an object, you are, in essence, **sending a message to that object**. This concept of "message sending" is fundamental to how objects communicate and interact in object-oriented systems. It''s like telling someone, "Please get me a glass of water." You (the sender) are sending a message ("get me a glass of water") to another person (the receiver), expecting them to perform the action.

In OOP, the "message" is the method call itself, including the method''s name and any parameters it requires. The object you''re calling the method on is the "receiver," and your code that makes the call is the "sender".

Consider two objects: a `Payroll` object and an `Employee` object. If the `Payroll` object needs the `Employee`''s Social Security number, it doesn''t directly access a private attribute. Instead, it **sends a message** to the `Employee` object by calling its `getSocialSecurityNumber()` method. The `Employee` object (the receiver) then responds by providing the requested information. This ensures that the `Employee` object **controls access to its own data**, upholding the principle of encapsulation.

```java
public class Employee {
    private String socialSecurityNumber;
    private String name;

    public Employee(String socialSecurityNumber, String name) {
        this.socialSecurityNumber = socialSecurityNumber;
        this.name = name;
    }

    // Public method (interface) to get the Social Security Number
    public String getSocialSecurityNumber() {
        return socialSecurityNumber;
    }

    // Public method (interface) to get the name
    public String getName() {
        return name;
    }
}

public class Payroll {
    public static void main(String[] args) {
        // Create an Employee object (receiver)
        Employee emp = new Employee("123-45-678", "Jane Doe");

        // Payroll object (sender) sends a message to the Employee object
        String ssNum = emp.getSocialSecurityNumber(); // Message: getSocialSecurityNumber()
        String empName = emp.getName();               // Message: getName()

        System.out.println("Processing payroll for " + empName + " (SSN: " + ssNum + ")");
    }
}
```

**Only the public methods of an object can be invoked by another object**. This controlled interaction via message passing is vital for building robust, modular, and interactive object-oriented systems.

### Using Multiple Object Constructors

**Constructors are special methods that are automatically invoked when a new object is created**. Their **primary purpose is to set the newly created object to an initial, stable, and safe state**. They ensure that essential attributes are properly set before the object is used, preventing unstable states or errors.

Sometimes, you might want to create objects in different ways, depending on the information available at the time of creation. This is where **constructor overloading** comes into play. **Constructor overloading allows a class to have multiple constructors, each with a different parameter list (or signature)**. This provides **flexibility in object creation**, enabling different initialisation paths based on context.

The system (compiler) automatically selects the appropriate constructor based on the arguments provided during object instantiation using the `new` keyword. The **signature** of a method (including constructors) consists of the method name and its parameter list; the return type is typically not part of the signature in Java and C#.

If you don''t explicitly define any constructors in your class, Java (and similar languages) will provide a **default, empty constructor** for you. However, it''s generally **good programming practice to always include at least one constructor** and initialise all attributes within it, even if to a default or `null` value, for clarity and maintenance.

Consider a `Product` class where you might want to create a product with just a name, or with a name and a price, or even with a name, price, and a unique product ID:

```java
public class Product {
    private String name;
    private double price;
    private String productId;

    // Constructor 1: Initialise with just a name (default productId and price)
    public Product(String name) {
        this.name = name;
        this.price = 0.0;
        this.productId = "PROD-" + System.currentTimeMillis(); // Generate a unique ID
        System.out.println("Product created: " + name + " (Default price, Generated ID)");
    }

    // Constructor 2: Initialise with name and price
    public Product(String name, double price) {
        this.name = name;
        this.price = price;
        this.productId = "PROD-" + System.currentTimeMillis();
        System.out.println("Product created: " + name + " (Price: " + price + ", Generated ID)");
    }

    // Constructor 3: Initialise with name, price, and specific product ID
    public Product(String name, double price, String productId) {
        this.name = name;
        this.price = price;
        this.productId = productId;
        System.out.println("Product created: " + name + " (Price: " + price + ", ID: " + productId + ")");
    }

    // Getter methods (for demonstration)
    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public String getProductId() {
        return productId;
    }
}

public class Store {
    public static void main(String[] args) {
        // Using Constructor 1
        Product item1 = new Product("Laptop");

        // Using Constructor 2
        Product item2 = new Product("Mouse", 25.99);

        // Using Constructor 3
        Product item3 = new Product("Keyboard", 75.00, "KB-001");

        System.out.println("\nItem 1: " + item1.getName() + " (ID: " + item1.getProductId() + ")");
        System.out.println("Item 2: " + item2.getName() + " (Price: " + item2.getPrice() + ")");
        System.out.println("Item 3: " + item3.getName() + " (ID: " + item3.getProductId() + ", Price: " + item3.getPrice() + ")");
    }
}
```

This powerful feature of constructor overloading allows you to tailor the object creation process to various scenarios, making your classes more flexible and user-friendly.

```mermaid
classDiagram
    class Object {
        +attribute1: Type
        +attribute2: Type
        +Object(params)
        +methodA(): void
        +methodB(arg: Type): ReturnType
    }

    class Client {
        +main(): void
    }

    class Product {
        -name: String
        -price: double
        -productId: String
        +Product(name: String)
        +Product(name: String, price: double)
        +Product(name: String, price: double, productId: String)
        +getName(): String
    }
    
    %% Relationships
    Client ..> Object : uses
    Client ..> Product : creates
```', 'Object Methods and Communication', 'This lesson explains how objects in OOP perform actions via methods, interact with each other through message passing, and can be initialized flexibly using multiple constructors to create versatile and well-structured programs.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('85d89de7-6e44-4910-804c-17dfc10cb0be', '### Bringing Blueprints to Life: Creating and Using Objects

In object-oriented programming, classes serve as **blueprints or templates** for creating objects. While a class defines the structure and behaviour that objects of its type will possess, it doesn''t actually exist in the computer''s memory as a concrete entity until an object is **instantiated** from it. Think of it like a cookie cutter: the cutter is the blueprint, but you need to use it to create actual cookies.

### Instantiating an Object from a Class

**Instantiation is the process of creating an instance of a class in memory, turning the blueprint into a concrete object**. When an object is created, it allocates its own separate resources, including its own copies of attributes and methods defined by the class. This means if you create three Employee objects, each will have its own distinct set of data in memory. In Java, the `new` keyword is used to create a new instance of a class. This keyword allocates the necessary memory for the new object and then invokes a special method known as the **constructor**. Here’s how you would typically instantiate a `Car` object:

```java
public class Car {
    String colour; // Attribute to hold the car''s colour
    String model;  // Attribute to hold the car''s model

    // Constructor (more on this next!)
    public Car(String colour, String model) {
        this.colour = colour;
        this.model = model;
    }

    public void startEngine() {
        System.out.println("The " + colour + " " + model + " engine is starting.");
    }
}

public class Dealership {
    public static void main(String[] args) {
        // Instantiating a Car object named myCar
        Car myCar = new Car("Red", "Sedan"); // The ''new'' keyword creates the object
        
        // You now have a concrete ''myCar'' object, an instance of the Car class
        myCar.startEngine();
    }
}
```

In the example above, `myCar` is an **object** (an instance of the `Car` class), while `Car` itself is the **class** (the blueprint).

### Initialising Objects with Constructors

**Constructors are special methods that are automatically invoked when a new object is created**. Their **primary purpose is to set the newly created object to an initial, stable, and safe state**. This is crucial to ensure that essential attributes are properly set before the object is used, preventing unstable states or errors. In languages like Java, a constructor shares the **same name as the class** and **does not have a return value**. If you provide a return value, the compiler won''t treat it as a constructor. Consider this `Cabbie` class constructor:

```java
public class Cabbie {
    private String name; // An attribute for the cabbie''s name
    private Cab myCab;   // An attribute for the cabbie''s assigned cab

    // Constructor: invoked automatically when a new Cabbie object is created
    public Cabbie() {
        // Initialising attributes to a safe, default state
        this.name = null; 
        this.myCab = null; 
        System.out.println("A new cabbie object has been created with default values.");
    }

    // Another constructor (overloaded) allowing initialisation with specific values
    public Cabbie(String name, String serialNumber) {
        this.name = name;
        this.myCab = new Cab(serialNumber); // Assuming Cab also has a constructor
        System.out.println("Cabbie " + name + " with cab " + serialNumber + " created.");
    }
}
```

**If you don''t explicitly include a constructor in your class, the system will provide a default, empty constructor for you**. However, it is **good programming practice to always include at least one constructor** and initialise all attributes within it, even if to a null or zero value. This makes your code clearer for documentation and maintenance, and it prevents potential issues if the default constructor is later implicitly removed when other constructors are added.

### Accessing Object Attributes

**Attributes store the state or information about an object**. While attributes contain the specific data for each object instance, they are **typically declared as private**. This private access modifier restricts direct external access, meaning only methods within that same class can directly access or modify the attribute. This practice is a cornerstone of **encapsulation** and helps maintain data integrity. So, if direct access is restricted, how do other objects interact with an object''s data? The answer lies in **accessor methods**, commonly known as **''getters'' and ''setters''**. These are public methods that provide controlled access to the private attributes.

  * **Getters** (e.g., `getName()`) allow other objects to retrieve the value of an attribute.
  * **Setters** (e.g., `setName()`) allow other objects to modify the value of an attribute. Setters are particularly useful because they can include **validation logic** before updating the attribute, ensuring data integrity and simplifying debugging.

Here’s an example using getters and setters for a `Person` class:

```java
public class Person {
    private String name; // Private attribute
    private int age;     // Private attribute

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // Getter for name
    public String getName() {
        return name;
    }

    // Setter for name with validation
    public void setName(String name) {
        if (name != null && !name.trim().isEmpty()) {
            this.name = name;
        } else {
            System.out.println("Name cannot be empty.");
        }
    }

    // Getter for age
    public int getAge() {
        return age;
    }

    // Setter for age with validation
    public void setAge(int age) {
        if (age >= 0) {
            this.age = age;
        } else {
            System.out.println("Age cannot be negative.");
        }
    }
}

public class TestPerson {
    public static void main(String[] args) {
        Person person1 = new Person("Alice", 30);

        // Accessing attributes using getters
        System.out.println("Person''s name: " + person1.getName());
        System.out.println("Person''s age: " + person1.getAge());

        // Modifying attributes using setters with validation
        person1.setName("Bob");
        person1.setAge(-5); // This will trigger the validation message

        System.out.println("Updated name: " + person1.getName());
        System.out.println("Updated age: " + person1.getAge());
    }
}
```

By instantiating objects and controlling access to their attributes through well-defined constructors and accessor methods, you build robust and maintainable object-oriented systems that accurately model real-world entities.

```mermaid
classDiagram
    class ClassName {
        -attribute1: Type
        -attribute2: Type
        +ClassName(params)
        +getAttribute1(): Type
        +setAttribute1(value: Type): void
        +doSomething(): void
    }

    class ObjectCreationProcess {
        +main(): void
    }

    class ObjectInteraction {
        +main(): void
    }

    ObjectCreationProcess --> ClassName : instantiates new
    ObjectInteraction --> ClassName : interacts with
    ObjectInteraction --|> ClassName : uses getters/setters
```', 'Object Instantiation and Access', 'This lesson covers how **objects are created from classes using constructors, how their attributes are initialized, and how encapsulation is maintained through getters and setters** to safely access and modify object data.');
INSERT INTO public.lessons (lesson_id, lesson_content, lesson_name, short_description) VALUES ('1f07b6a7-f210-4983-91cb-a3abbbc25c46', 'Welcome to our deep dive into **Encapsulation**, one of the foundational pillars of Object-Oriented Programming (OOP). At its heart, encapsulation is about creating **self-contained units** that bundle both **data (attributes)** and the **methods (behaviours)** that operate on that data. Think of an object as a neat, complete package where everything it needs to function correctly is kept together.

## Understanding the Benefits of Encapsulation

Why is encapsulation so crucial in software design? It offers several significant advantages that lead to more robust, maintainable, and secure systems.

1. **Data Protection and Integrity**: Encapsulation acts as a guardian for your data. By restricting direct external access to an object''s internal state, it ensures that data cannot be inadvertently or maliciously altered. Instead of allowing any part of the program to change data, controlled access is provided through specific methods, often called ''getters'' and ''setters''. This means that if a bug arises, you only need to look in one place (the setter method) to track down where the data might have been changed, greatly simplifying debugging.

2. **Reduced Complexity and Enhanced Modularity**: Encapsulation hides complex implementation details, presenting only the essential features to other parts of the system. This ''black box'' approach simplifies how other objects interact with it. For instance, when you use a calculator, you only interact with its keypad and display (the interface); you don''t need to know the intricate electronic or algorithmic details of how it computes sums. This separation fosters modular design, where components can be developed and maintained independently, reducing interdependencies between different parts of your code.

```mermaid
graph TD
    A[Requesting Object] -->|Sends Message| B[Interface]
    B -->|Invokes| C[Implementation - Hidden Details]
    C -->|Returns Result| B
    B -->|Provides Result| A
```

3. **Preventing Unintended Side Effects**: By controlling access, encapsulation prevents other, logically unconnected functions or objects from directly manipulating internal attributes, thereby safeguarding the object''s stable state. This control is vital for system stability and preventing errors. Imagine an ATM: access to your account data is controlled by your PIN, ensuring only authorised operations.

## Applying Encapsulation Principles

To effectively implement encapsulation, you must adhere to certain design practices:

1. **Declare Class Members with Appropriate Access Modifiers**: The cornerstone of encapsulation is the judicious use of access modifiers, primarily `private` and `public`.

    *   **`private`**: This modifier restricts direct external access, making attributes and methods strictly part of the class''s internal implementation. The principle is to **hide as much data as possible**. If data is declared `public`, it breaks the concept of data hiding.
    *   **`public`**: These members define the services a class offers to other objects, forming its external Application Programming Interface (API). Public methods allow interaction with the class, ensuring a **minimal public interface** is exposed – only what external users absolutely need. Private methods, conversely, are internal helper functions not intended for direct access by other classes.

2. **Use Public Methods (Getters and Setters) for Controlled Data Access**: Since attributes are typically declared `private`, public methods (accessors and mutators) are used as a gateway for other objects to interact with them. These methods can include validation logic or other operations before data is set or retrieved, ensuring data integrity.

    Let''s consider a `BankAccount` example, where the `balance` is kept `private` to prevent direct manipulation, and `deposit()` and `withdraw()` are public methods that control how the `balance` is modified.

    ```java
    public class BankAccount {
        private double balance; // Private attribute
        private String accountNumber;

        public BankAccount(String accountNumber, double initialBalance) {
            this.accountNumber = accountNumber;
            this.balance = initialBalance;
        }

        // Public method to deposit money (mutator/setter concept)
        public void deposit(double amount) {
            if (amount > 0) {
                this.balance += amount;
                System.out.println("Deposited: " + amount + ". New balance: " + this.balance);
            } else {
                System.out.println("Deposit amount must be positive.");
            }
        }

        // Public method to withdraw money (mutator/setter concept)
        public void withdraw(double amount) {
            if (amount > 0 && this.balance >= amount) {
                this.balance -= amount;
                System.out.println("Withdrew: " + amount + ". New balance: " + this.balance);
            } else if (amount <= 0) {
                System.out.println("Withdrawal amount must be positive.");
            } else {
                System.out.println("Insufficient funds. Current balance: " + this.balance);
            }
        }

        // Public method to get balance (accessor/getter)
        public double getBalance() {
            return this.balance;
        }

        // Public method to get account number (accessor/getter)
        public String getAccountNumber() {
            return this.accountNumber;
        }

        // An example of a private helper method
        private void logTransaction(String type, double amount) {
            System.out.println("Internal Log: " + type + " of " + amount + " on account " + this.accountNumber);
        }
    }
    ```

    In this example, the `balance` can only be changed via `deposit()` and `withdraw()` methods, which include validation logic. This ensures that the bank account maintains a valid state and prevents direct, uncontrolled manipulation of the balance. The `logTransaction` method is `private` because it''s an internal detail not meant for external use, further exemplifying how internal logic is hidden.

By consistently applying these encapsulation principles, you create highly maintainable, secure, and understandable code that stands the test of time.', 'The Core of Encapsulation', 'This lesson is about Encapsulation in Object-Oriented Programming. It explains how to bundle an object''s data (attributes) and methods (behaviors) together, hide internal details using `private` members, and provide controlled access through `public` methods to ensure data integrity, security, and modularity.');


--
-- Data for Name: lesson_kc_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', 'dcccc6fc-222e-4ecd-be3a-068acc1201f7');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.65, '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'dcccc6fc-222e-4ecd-be3a-068acc1201f7');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.75, 'ea329450-6108-4b0b-88fb-df8609932bde', 'dcccc6fc-222e-4ecd-be3a-068acc1201f7');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '8b0e0b53-1138-4984-82a0-c68171222de0');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.75, '148f7ad4-89e4-4454-8acb-7041c7876824', '8b0e0b53-1138-4984-82a0-c68171222de0');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.75, '9fbe5a80-4649-445d-8bf2-a4c4795d8571', 'df259a57-6410-451f-9750-6354d522d76d');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'df259a57-6410-451f-9750-6354d522d76d');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.70, '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', 'df259a57-6410-451f-9750-6354d522d76d');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, '469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'c5c232d1-7640-42d8-9517-795d094190fa');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.78, '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'c5c232d1-7640-42d8-9517-795d094190fa');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.80, 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'c5c232d1-7640-42d8-9517-795d094190fa');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, '803a4f07-4b9b-4428-855c-56931180ac44', '85d89de7-6e44-4910-804c-17dfc10cb0be');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, '36e59beb-3737-4a17-b8b0-d240ff8fd674', '85d89de7-6e44-4910-804c-17dfc10cb0be');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.88, '61240d41-e0e0-4f01-8315-01c8e433eaf9', '85d89de7-6e44-4910-804c-17dfc10cb0be');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, 'ae3025ca-1a56-4f7a-975c-c19a839427bd', 'a51e1cf9-daab-42f7-8b65-754de29300b5');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', 'a51e1cf9-daab-42f7-8b65-754de29300b5');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.88, 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0', 'a51e1cf9-daab-42f7-8b65-754de29300b5');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, '97a48d3a-8282-4216-a58b-cbf75d3c7023', '1f07b6a7-f210-4983-91cb-a3abbbc25c46');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, '1323bbe7-116c-4fb1-b059-b8a07e0916ca', '1f07b6a7-f210-4983-91cb-a3abbbc25c46');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, '2ed95544-8955-4b79-abda-d09f8d9499d1', 'ff7627f7-e36a-4c23-abce-bf5bc95087db');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', 'ff7627f7-e36a-4c23-abce-bf5bc95087db');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, '1db3b49c-dfef-4855-94df-45b59047fa25', 'ff7627f7-e36a-4c23-abce-bf5bc95087db');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', '20b3450a-baaa-413d-b7ea-c598874439f8');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, '7bd074f2-04d0-462c-8d0d-a53ac985e077', '20b3450a-baaa-413d-b7ea-c598874439f8');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.88, '4d11f382-1287-4e52-b80f-d2dc1e655725', '20b3450a-baaa-413d-b7ea-c598874439f8');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', '9a4f0331-fe2f-4689-826d-4fd87dc34225');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '9a4f0331-fe2f-4689-826d-4fd87dc34225');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.75, '80c78721-2a0d-4a7d-aca6-28513b321eee', '41c441dd-1cf1-41b8-a1a3-d182683f78fa');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', '41c441dd-1cf1-41b8-a1a3-d182683f78fa');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.80, '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '41c441dd-1cf1-41b8-a1a3-d182683f78fa');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', 'f6fedc4e-809f-4e68-a478-c6597593b6b6');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'fbc5a89e-8d85-4408-87c9-ed75e2e13e53');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'fbc5a89e-8d85-4408-87c9-ed75e2e13e53');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.88, '9e116c2d-907b-4027-abf4-1c427f5b9055', 'fbc5a89e-8d85-4408-87c9-ed75e2e13e53');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.92, '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '344a3249-fb11-4666-8fec-1df09e0553c4');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, 'a3878dc5-979e-47f1-b344-e8fa69845ef6', '344a3249-fb11-4666-8fec-1df09e0553c4');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, '6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'cded15bd-d98e-4da6-accc-0cdcd72086a8');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, 'aba7461f-882c-49dc-8007-8e14801cb4df', 'cded15bd-d98e-4da6-accc-0cdcd72086a8');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'cded15bd-d98e-4da6-accc-0cdcd72086a8');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, 'eaa51591-8133-4516-9db3-8848b9571cd9', '3de328c4-0659-43e9-b5e8-7882f6b02878');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '3de328c4-0659-43e9-b5e8-7882f6b02878');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, '96207b35-90f2-4236-9886-7760d38e42ad', 'bee88569-4567-4b2e-89ec-de60bc596bc0');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.88, '9b66ba2c-d515-4710-8312-336840750dc1', 'bee88569-4567-4b2e-89ec-de60bc596bc0');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '1b6f4bd4-6af5-4095-ad7f-69978772bc3b');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, 'ce845442-0c3d-4de6-bbe6-765445fbfe06', '1b6f4bd4-6af5-4095-ad7f-69978772bc3b');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.90, 'c83bb940-8d84-4bc2-ae69-0c8757207c77', 'd20feaf3-2abc-418e-8986-c2d5a4b4c725');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.85, 'f301d039-f264-4188-b368-39bad0e05c1c', 'd20feaf3-2abc-418e-8986-c2d5a4b4c725');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'df7f776a-f96b-4347-be09-88d458ced907');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.92, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', 'df7f776a-f96b-4347-be09-88d458ced907');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.88, '1889697c-ddf5-4397-b94f-ecad3a5e71dd', 'df7f776a-f96b-4347-be09-88d458ced907');
INSERT INTO public.lesson_kc_mapping (target_mastery, kc_id, lesson_id) VALUES (0.95, 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '431920e5-a5df-4a0f-abf2-8d8dd6a22ea9');


--
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.modules (module_id, description, module_name) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'This module covers the core principles of object-oriented programming including encapsulation, inheritance, polymorphism, and abstraction.', 'Object Oriented Programming');


--
-- Data for Name: module_kc_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f947c4d8-c88b-4522-acd2-59d9cf755d48');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9e116c2d-907b-4027-abf4-1c427f5b9055');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'aba7461f-882c-49dc-8007-8e14801cb4df');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f0151e0a-4d88-4160-b9df-3d8eff23d352');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1889697c-ddf5-4397-b94f-ecad3a5e71dd');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '2ed95544-8955-4b79-abda-d09f8d9499d1');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f301d039-f264-4188-b368-39bad0e05c1c');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '879a304b-b2d3-46c6-982e-e75ef475d4e2');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ea329450-6108-4b0b-88fb-df8609932bde');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'e293e2c6-99a8-49c9-97d2-fd67086cdef3');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '803a4f07-4b9b-4428-855c-56931180ac44');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '447c13bc-d60e-4032-8d0c-af9837b04ab2');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f8e293fe-8bdf-44cc-9a73-412520a80e62');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '36e59beb-3737-4a17-b8b0-d240ff8fd674');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '148f7ad4-89e4-4454-8acb-7041c7876824');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '22ff0a1d-bfb4-4d88-862a-29ec02a744fa');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ae3025ca-1a56-4f7a-975c-c19a839427bd');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1323bbe7-116c-4fb1-b059-b8a07e0916ca');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '96207b35-90f2-4236-9886-7760d38e42ad');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c83bb940-8d84-4bc2-ae69-0c8757207c77');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '97a48d3a-8282-4216-a58b-cbf75d3c7023');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ba935e44-3c0f-41f3-9467-154a61f3d4c5');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'eaa51591-8133-4516-9db3-8848b9571cd9');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'a3878dc5-979e-47f1-b344-e8fa69845ef6');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ce845442-0c3d-4de6-bbe6-765445fbfe06');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7a3b6aa3-01d2-4374-896e-33fdb9b3d428');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '80c78721-2a0d-4a7d-aca6-28513b321eee');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '61240d41-e0e0-4f01-8315-01c8e433eaf9');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9b66ba2c-d515-4710-8312-336840750dc1');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1c06c13-6f5e-49b6-a948-048f2c8bb455');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '6db88066-a65a-4b3b-8f33-ac536a0f44e8');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '07300d73-2d8d-46d6-a735-c1caa0bddaf0');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9fbe5a80-4649-445d-8bf2-a4c4795d8571');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1db3b49c-dfef-4855-94df-45b59047fa25');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7517905d-9f0b-4eeb-8e80-2718ebfb5a72');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '469ed793-d86f-4dff-b2fc-70b77e83a0eb');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7bd074f2-04d0-462c-8d0d-a53ac985e077');
INSERT INTO public.module_kc_mapping (module_id, kc_id) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '4d11f382-1287-4e52-b80f-d2dc1e655725');


--
-- Data for Name: module_kc_prerequisite; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9e116c2d-907b-4027-abf4-1c427f5b9055', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the fundamental distinction between a class (blueprint) and an object (instance) is essential before grasping how subclasses are a "type of" superclass.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'aba7461f-882c-49dc-8007-8e14801cb4df', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because a learner must know how to define a class structure before they can implement methods that fulfill an abstract contract within that class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'aba7461f-882c-49dc-8007-8e14801cb4df', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because implementing abstract contracts primarily involves providing concrete code for methods, requiring a foundational understanding of how to define class methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'aba7461f-882c-49dc-8007-8e14801cb4df', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'This KC is a prerequisite because understanding what abstract classes and abstract methods are is essential before a learner can implement their contracts.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'aba7461f-882c-49dc-8007-8e14801cb4df', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite because interfaces are a type of abstract contract, and knowing how to define an interface is foundational to implementing its promises.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'This KC is a prerequisite because it introduces the fundamental concept of abstraction, which is essential for understanding how to identify essential features and hide implementation details in interface design.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite because understanding the clear distinction between a class''s public interface and its internal implementation is foundational for applying abstraction in interface design.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', 'This KC is a prerequisite as it teaches the principle of designing concise public interfaces, which directly supports the goal of identifying and exposing only essential features in interface design.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite because knowing the definition and purpose of an interface is crucial before one can effectively apply abstraction principles to its design.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f0151e0a-4d88-4160-b9df-3d8eff23d352', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite because understanding the fundamental distinction between an interface and its implementation is crucial for designing abstract interfaces that promote reusability by hiding internal details.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f0151e0a-4d88-4160-b9df-3d8eff23d352', '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'This KC is a prerequisite because identifying all potential users of a class is essential for designing an abstract interface that meets diverse user goals and ensures consistency and reusability across different contexts.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f0151e0a-4d88-4160-b9df-3d8eff23d352', '1889697c-ddf5-4397-b94f-ecad3a5e71dd', 'This KC is a prerequisite as it enables the identification of necessary object behaviors and constraints, which directly informs the creation of general and reusable abstract interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f0151e0a-4d88-4160-b9df-3d8eff23d352', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite because knowing the syntax and purpose of defining an interface is foundational to then design it for reusability, as it establishes the contract for behavior.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the distinction between classes and objects is foundational to determining the behaviors of a specific object.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite as it covers the definition of class methods, which are the fundamental building blocks for an object''s behaviors.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'This KC is a prerequisite because identifying all potential users of a class or system is crucial for accurately determining the necessary behaviors from their perspective.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '7bd074f2-04d0-462c-8d0d-a53ac985e077', 'This KC is a prerequisite because designing public class interfaces directly relates to defining the observable actions and methods an object will expose to its users.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC establishes the foundational understanding of what a class is in contrast to an object, which is essential before identifying users of a class or system.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC provides the foundational understanding of what a public interface is, which is essential for identifying who would be interacting with it.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'ae3025ca-1a56-4f7a-975c-c19a839427bd', 'This KC explains how objects interact by sending messages, which is fundamental to identifying "all potential entities that might send messages to or receive services from a class" for interface design.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '2ed95544-8955-4b79-abda-d09f8d9499d1', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the fundamental distinction between classes (blueprints) and objects (instances) is essential before differentiating parts within a class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '2ed95544-8955-4b79-abda-d09f8d9499d1', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because learners must know how to define the basic structure of a class before understanding its public interface and internal implementation.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because understanding how to define a basic class is foundational to comprehending how a new class can inherit from an existing one.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because a clear understanding of the difference between a class (blueprint) and an object (instance) is essential before delving into how class blueprints can extend each other through inheritance.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'This KC is a prerequisite as it introduces the fundamental terminology of superclasses and subclasses, which are central to defining and applying class inheritance.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', '9e116c2d-907b-4027-abf4-1c427f5b9055', 'This KC is a prerequisite because understanding the conceptual "is-a" relationship is crucial for correctly modeling and applying inheritance in object-oriented design.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'Understanding and applying class inheritance is fundamental as abstract classes are a type of base class in an inheritance hierarchy, requiring subclasses to extend and implement their abstract methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'Differentiating between superclasses and subclasses is crucial for understanding how abstract classes serve as superclasses and how their abstract methods are implemented in concrete subclasses.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'Grasping the distinction between interface (what a class does) and implementation (how it does it) is the core concept of abstraction, which abstract classes and methods directly embody.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'a3878dc5-979e-47f1-b344-e8fa69845ef6', 'Implementing polymorphism via method overriding is essential because abstract methods in a superclass must be overridden and provided with concrete implementations in their respective subclasses.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite as it covers the crucial concept of access modifiers (private/public), which directly enable the hiding of internal implementation details from the public interface.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '2ed95544-8955-4b79-abda-d09f8d9499d1', '1323bbe7-116c-4fb1-b059-b8a07e0916ca', 'This KC is a prerequisite because applying encapsulation principles is the fundamental design concept that mandates the separation of a class''s interface from its internal implementation, promoting data hiding and modularity.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f301d039-f264-4188-b368-39bad0e05c1c', '148f7ad4-89e4-4454-8acb-7041c7876824', 'Understanding the fundamental distinction between a class and an object is crucial before identifying the specific elements that constitute a class in a UML diagram.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f301d039-f264-4188-b368-39bad0e05c1c', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'To correctly identify attributes in a UML Class Diagram, a learner must first understand what class attributes are and their purpose in defining an object''s state.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f301d039-f264-4188-b368-39bad0e05c1c', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'To correctly identify methods in a UML Class Diagram, a learner must first understand what class methods are and their purpose in defining an object''s behaviors.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because a learner must know how to define a basic class structure before they can apply access modifiers to its members.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'This KC is a prerequisite as understanding how to define class attributes (object data) is essential before controlling their visibility with access modifiers.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because a learner needs to know how to define class methods (object behaviors) before applying access modifiers to them.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '879a304b-b2d3-46c6-982e-e75ef475d4e2', '148f7ad4-89e4-4454-8acb-7041c7876824', 'To understand superclasses and subclasses, a learner must first grasp the fundamental distinction between a class (a blueprint) and an object (an instance).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '879a304b-b2d3-46c6-982e-e75ef475d4e2', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'Before understanding how classes relate through inheritance, a learner needs to know how to define a basic class, which provides the foundational "building block".');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the conceptual distinction between classes and objects is essential, as composition involves one class containing instances (objects) of other classes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because a learner must be able to define the basic structure of a class before it can act as a container for other objects through composition.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'This KC is a prerequisite because object composition requires including instances of other classes as attributes within the composing class, which is covered by defining class attributes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '803a4f07-4b9b-4428-855c-56931180ac44', 'This KC is a prerequisite because composition involves one class containing instances of other classes, which necessitates knowing how to instantiate objects from a class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ea329450-6108-4b0b-88fb-df8609932bde', '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', 'This KC provides the foundational understanding of procedural programming principles, which is essential to contextualize the role and purpose of functions within this paradigm.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ea329450-6108-4b0b-88fb-df8609932bde', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'This KC covers data management concepts like variable scope and parameter passing, which are crucial for understanding how data is handled when defining and invoking functions.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', 'This KC establishes the foundational understanding of what procedural programming is, which is essential before understanding how data is handled specifically within that paradigm.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', 'This KC provides a foundational understanding of the core principles of procedural programming, which is essential for comparing and contrasting it with the object-oriented paradigm.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', 'ea329450-6108-4b0b-88fb-df8609932bde', 'Understanding how functions are identified and utilized in procedural programming is crucial for grasping the procedural approach and its contrast with object-oriented methodologies.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'This KC covers data management in procedural programming, which is a key area of contrast with OOP’s data encapsulation and modularity principles.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '148f7ad4-89e4-4454-8acb-7041c7876824', 'A basic understanding of the distinction between classes and objects is fundamental for comprehending the core concepts of object-oriented programming, enabling effective comparison with the procedural paradigm.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '803a4f07-4b9b-4428-855c-56931180ac44', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because a learner must understand the fundamental distinction between a class (blueprint) and an object (instance) before they can create an instance of a class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '803a4f07-4b9b-4428-855c-56931180ac44', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because a class must be defined as a blueprint before an object can be instantiated from it.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '447c13bc-d60e-4032-8d0c-af9837b04ab2', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the conceptual distinction between a class (blueprint) and an object (instance) is essential before a learner can define the class blueprint itself.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'ea329450-6108-4b0b-88fb-df8609932bde', 'This KC is a prerequisite because methods within a class are essentially functions. A foundational understanding of defining, parameterizing, and invoking functions in a procedural context is necessary before learning to define methods as part of a class structure.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '447c13bc-d60e-4032-8d0c-af9837b04ab2', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'This KC is a prerequisite because classes encapsulate data in the form of attributes. Understanding concepts like variables, data types, and scope from procedural programming is foundational for grasping how data is defined and managed within a class structure.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC provides the fundamental understanding of what classes and objects are, which is essential before learning to define data (attributes) that belong to objects created from a class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is required to understand the basic syntax and structure of a class, within which attributes are defined.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'ea329450-6108-4b0b-88fb-df8609932bde', 'Understanding functions is crucial for grasping how methods like `__init__` work, which are commonly used to define and initialize class attributes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'This KC provides foundational knowledge of how data is managed and scoped in programming, directly relevant to understanding how attributes store and manage object-specific data.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the distinction between a class as a blueprint and an object as an instance is essential for grasping that methods define the behaviors of objects.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because defining methods requires a foundational understanding of how to declare the basic structure of a class in which these methods will reside.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'ea329450-6108-4b0b-88fb-df8609932bde', 'This KC is a prerequisite as class methods are specialized functions; a basic understanding of function definition, parameters, and invocation from procedural programming is crucial.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '36e59beb-3737-4a17-b8b0-d240ff8fd674', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because a learner must understand the distinction between a class and an object before they can interact with object attributes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '36e59beb-3737-4a17-b8b0-d240ff8fd674', '803a4f07-4b9b-4428-855c-56931180ac44', 'This KC is a prerequisite because an object must be instantiated from a class before its attributes can be accessed.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '36e59beb-3737-4a17-b8b0-d240ff8fd674', '469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'This KC is a prerequisite because understanding how class attributes are declared and what they represent is fundamental to accessing them from an object.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', '803a4f07-4b9b-4428-855c-56931180ac44', 'This KC is a prerequisite because an object must be instantiated (created) from a class before any methods can be invoked on it.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because understanding how methods are defined as object behaviors within a class is essential before a student can successfully call them.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', 'ae3025ca-1a56-4f7a-975c-c19a839427bd', 'This KC is a prerequisite because invoking a method is a form of message sending in OOP; understanding this conceptual model provides a crucial foundation for object interaction.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ae3025ca-1a56-4f7a-975c-c19a839427bd', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the distinction between classes and objects is essential for comprehending that messages are sent between concrete instances (objects).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ae3025ca-1a56-4f7a-975c-c19a839427bd', '803a4f07-4b9b-4428-855c-56931180ac44', 'This KC is a prerequisite because before objects can communicate via messages, learners must understand how to create (instantiate) these objects.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ae3025ca-1a56-4f7a-975c-c19a839427bd', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because messages sent between objects are essentially calls to their methods, so understanding how methods define object behaviors is crucial.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1323bbe7-116c-4fb1-b059-b8a07e0916ca', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'This KC is a prerequisite because understanding how to define class attributes (object data) is fundamental before one can apply access restrictions to them through encapsulation.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1323bbe7-116c-4fb1-b059-b8a07e0916ca', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because defining class methods is essential for creating the public methods (like getters and setters) that are used to control access to encapsulated data.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1323bbe7-116c-4fb1-b059-b8a07e0916ca', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite because it directly covers understanding and applying access modifiers (private, public), which are the core mechanisms for implementing encapsulation.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '96207b35-90f2-4236-9886-7760d38e42ad', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite because it covers the fundamental syntax and purpose of defining an interface, which is essential for understanding its distinct role when distinguishing it from an abstract class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '96207b35-90f2-4236-9886-7760d38e42ad', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'This KC is a prerequisite because it covers the concept and application of abstract classes and methods, which is crucial for identifying their characteristics to differentiate them from interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '96207b35-90f2-4236-9886-7760d38e42ad', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'This KC is a prerequisite because understanding class inheritance is foundational for comprehending how abstract classes are extended and their role in a class hierarchy, a key aspect when comparing them to interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '96207b35-90f2-4236-9886-7760d38e42ad', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite because grasping the distinction between an interface (what it does) and its implementation (how it does it) is essential for a deeper understanding of interfaces, aiding in their differentiation from abstract classes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c83bb940-8d84-4bc2-ae69-0c8757207c77', 'f301d039-f264-4188-b368-39bad0e05c1c', 'This KC is a prerequisite because learners must first be able to identify the basic elements of a class (name, attributes, methods) within a UML diagram before understanding how classes relate to each other.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c83bb940-8d84-4bc2-ae69-0c8757207c77', '9e116c2d-907b-4027-abf4-1c427f5b9055', 'This KC is a prerequisite as it covers the foundational concept of the `is-a` relationship, which is essential for understanding inheritance as a type of class relationship in UML diagrams.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c83bb940-8d84-4bc2-ae69-0c8757207c77', 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', 'This KC is a prerequisite because it covers object composition, which is fundamental to understanding `has-a` relationships, a key type of relationship depicted in UML class diagrams.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the distinction between a class (blueprint) and an object (instance) is fundamental before interacting with an object through method invocation.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1323bbe7-116c-4fb1-b059-b8a07e0916ca', 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', 'This KC is a prerequisite because it covers the practical application of using getters and setters, which are explicitly mentioned as a means to control data access and modification in encapsulation.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because getters and setters are methods that are defined within a class structure.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'This KC is a prerequisite because getters and setters are used to access and modify private instance variables (attributes).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because getters and setters are specific types of class methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite because getters and setters are specifically used to provide controlled public access to private class members.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '97a48d3a-8282-4216-a58b-cbf75d3c7023', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the distinction between classes and objects is fundamental to comprehending how encapsulation applies to object-oriented programming entities.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '97a48d3a-8282-4216-a58b-cbf75d3c7023', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite as defining a class structure is the foundational step for creating the blueprint upon which encapsulation principles are applied.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '97a48d3a-8282-4216-a58b-cbf75d3c7023', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite because encapsulation fundamentally relies on the ability to define private and public members to control data access and hide internal details.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '97a48d3a-8282-4216-a58b-cbf75d3c7023', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite as understanding the difference between an interface and its implementation is crucial for appreciating how encapsulation separates these concerns and provides its benefits.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite because it covers the fundamental distinction between a class''s public interface and its internal implementation, which is the core concept behind programming to interfaces rather than implementations.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'This KC is a prerequisite as understanding abstraction, including through abstract classes and methods, is foundational to grasping why interfaces are used to hide implementation details and define common behavior.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite because one must know how to define an interface before being able to apply the paradigm of programming to it.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'This KC is a prerequisite because implementing an interface is the practical step required to provide concrete behavior for the abstract contract, essential for the interface/implementation paradigm.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'eaa51591-8133-4516-9db3-8848b9571cd9', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite because it covers the fundamental concept and syntax of defining an interface, which is essential before understanding how interfaces enable polymorphism.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'eaa51591-8133-4516-9db3-8848b9571cd9', '6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'This KC is a prerequisite because understanding how a class implements an interface is crucial for comprehending how objects of different classes can adhere to a common interface type.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'eaa51591-8133-4516-9db3-8848b9571cd9', 'a3878dc5-979e-47f1-b344-e8fa69845ef6', 'This KC is a prerequisite because it introduces the core concept of polymorphism through method overriding, providing a foundational understanding of how different objects can respond to the same message in unique ways, which is then extended by interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'a3878dc5-979e-47f1-b344-e8fa69845ef6', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'Method overriding is a core concept within inheritance, requiring an understanding of how subclasses inherit from superclasses.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'a3878dc5-979e-47f1-b344-e8fa69845ef6', '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'To implement method overriding, learners must differentiate between the superclass (where the original method is defined) and the subclass (where it is overridden).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'a3878dc5-979e-47f1-b344-e8fa69845ef6', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'Overriding involves redefining a method; thus, a foundational understanding of how to define methods within a class is essential.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'a3878dc5-979e-47f1-b344-e8fa69845ef6', 'ae3025ca-1a56-4f7a-975c-c19a839427bd', 'Polymorphism via method overriding is realized through message sending, where the runtime object determines which overridden method is invoked, making this a crucial prerequisite.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ce845442-0c3d-4de6-bbe6-765445fbfe06', '9e116c2d-907b-4027-abf4-1c427f5b9055', 'This KC is a prerequisite because it covers the foundational concept of the `is-a` relationship, which is crucial for understanding one half of the differentiation in the main KC.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ce845442-0c3d-4de6-bbe6-765445fbfe06', 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', 'This KC is a prerequisite because it covers the implementation and concept of the `has-a` relationship through composition, which is essential for understanding the other half of the differentiation in the main KC.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ce845442-0c3d-4de6-bbe6-765445fbfe06', '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'This KC is a prerequisite because understanding the roles of superclasses and subclasses is fundamental to comprehending the mechanics of inheritance and the `is-a` relationship.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite because understanding the fundamental distinction between a class''s public interface and its internal implementation is essential before learning to minimize that public interface.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite because the ability to define private and public members is the technical foundation for controlling what is exposed in a minimal public interface.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'This KC is a prerequisite as identifying all class users and their needs is crucial for determining what functionality external users "absolutely need" to interact with the class, thereby informing the design of a minimal interface.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', '7bd074f2-04d0-462c-8d0d-a53ac985e077', 'This KC is a prerequisite because designing public class interfaces, which involves defining the services a class offers, is a direct foundational skill for then learning how to minimize those interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '80c78721-2a0d-4a7d-aca6-28513b321eee', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because understanding how to define a class structure is essential for creating the custom data types or objects on which operator overloading will be applied.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '80c78721-2a0d-4a7d-aca6-28513b321eee', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because operator overloading involves defining special methods within a class that correspond to the overloaded operators, so understanding class methods is foundational.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '80c78721-2a0d-4a7d-aca6-28513b321eee', '803a4f07-4b9b-4428-855c-56931180ac44', 'This KC is a prerequisite because to observe and test custom operator behavior, learners must first be able to instantiate objects of the custom data types.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '80c78721-2a0d-4a7d-aca6-28513b321eee', '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', 'This KC is a prerequisite because operator overloading is an implicit way of invoking a method when an operator is used, so understanding method invocation is crucial.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '61240d41-e0e0-4f01-8315-01c8e433eaf9', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'Before understanding constructors, which are part of a class, a learner must first know how to define a class as the blueprint for objects.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '61240d41-e0e0-4f01-8315-01c8e433eaf9', '469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'Constructors'' primary purpose is to initialize an object''s attributes, so understanding what attributes are and how to declare them is essential.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '61240d41-e0e0-4f01-8315-01c8e433eaf9', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'Constructors are a special type of method, so a foundational understanding of how to define methods within a class is necessary.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '61240d41-e0e0-4f01-8315-01c8e433eaf9', '803a4f07-4b9b-4428-855c-56931180ac44', 'Constructors are automatically invoked when an object is instantiated, making the understanding of object creation a direct prerequisite.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9b66ba2c-d515-4710-8312-336840750dc1', 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'This KC is a prerequisite because understanding the fundamental concept of single class inheritance is essential before learning about and evaluating the complexities of inheriting from multiple parent classes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9b66ba2c-d515-4710-8312-336840750dc1', '9e116c2d-907b-4027-abf4-1c427f5b9055', 'This KC is a prerequisite because a clear grasp of the "is-a" relationship in single inheritance is foundational to comprehending how a class can have multiple "is-a" relationships in multiple inheritance.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9b66ba2c-d515-4710-8312-336840750dc1', '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'This KC is a prerequisite as differentiating between superclasses and subclasses is a core concept in any form of inheritance, including multiple inheritance.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9b66ba2c-d515-4710-8312-336840750dc1', '96207b35-90f2-4236-9886-7760d38e42ad', 'This KC is a prerequisite because understanding the distinction between interfaces and abstract classes is crucial for evaluating why certain languages prefer interfaces as an alternative to conventional multiple inheritance, as mentioned in the description.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0', '61240d41-e0e0-4f01-8315-01c8e433eaf9', 'This KC is a prerequisite because it covers the fundamental concept of constructors, which is essential before understanding how to use multiple constructors.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0', '803a4f07-4b9b-4428-855c-56931180ac44', 'This KC is a prerequisite as it covers the process of creating an object instance, which is when constructors are invoked and multiple constructors would be selected.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', 'ea329450-6108-4b0b-88fb-df8609932bde', 'This KC is a prerequisite because understanding functions and their execution is essential to grasp where and how exceptions can occur within blocks of code, especially within `try` blocks.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'This KC is a prerequisite as many runtime errors (exceptions) are caused by issues related to data manipulation or invalid data states. A fundamental understanding of data handling, including variables and types, is crucial for comprehending the source of exceptions.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', 'This KC provides the foundational understanding of how programs execute sequentially and how control flow operates, which is necessary before learning about abnormal control flow mechanisms like exceptions and `try/catch` blocks.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'This KC introduces the fundamental concept of local versus global variables and parameter passing in a procedural context, which is foundational for understanding local scope within methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', '148f7ad4-89e4-4454-8acb-7041c7876824', 'To differentiate between object and class scope, a learner must first understand the fundamental distinctions between classes (blueprints) and objects (instances).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', '469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'This KC covers the declaration and nature of class attributes, including the concept of `static` attributes and access modifiers, which are crucial for understanding how data is scoped within objects and classes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the fundamental distinction between a class (blueprint) and an object (instance) is essential before delving into how objects are copied.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '803a4f07-4b9b-4428-855c-56931180ac44', 'This KC is a prerequisite because understanding how to create an object from a class (instantiation) is foundational to comprehending how copies of objects are made in memory.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '36e59beb-3737-4a17-b8b0-d240ff8fd674', 'This KC is a prerequisite because knowing how to access object attributes is critical for understanding how shallow copies duplicate references to these attributes and how deep copies recursively duplicate the attributes themselves.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '6db88066-a65a-4b3b-8f33-ac536a0f44e8', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because implementing an interface requires the fundamental ability to define a concrete class structure.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '6db88066-a65a-4b3b-8f33-ac536a0f44e8', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite as one must understand how to define an interface before a class can implement its contract.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '6db88066-a65a-4b3b-8f33-ac536a0f44e8', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because implementing an interface involves providing concrete implementations for its abstract methods, which are essentially class methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '6db88066-a65a-4b3b-8f33-ac536a0f44e8', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'This KC is a prerequisite as interfaces are a form of abstraction; understanding abstract methods and the concept of abstraction is crucial for implementing interface contracts.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC provides the fundamental conceptual understanding of the distinction between an interface and its implementation, which is directly applied when recognizing these elements in code.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'Understanding how class methods are defined, including their signature and body, is essential for a learner to pinpoint these specific parts as representing either the interface or implementation.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'A foundational understanding of how a class is structured in code is necessary to then identify and differentiate its interface and implementation elements.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'An interface defines a contract that classes must implement. Therefore, understanding the basic structure of a class is foundational before learning how to define contracts for them.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'Interfaces primarily consist of abstract methods. Learners need to understand what methods are and how they represent object behaviors before comprehending abstract methods in an interface.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', 'Interfaces are a key mechanism for achieving abstraction in OOP. Understanding the general concept of abstraction and how it''s applied through abstract classes and methods provides a solid conceptual foundation for interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'Defining an interface is precisely about specifying "what" without "how." This KC directly addresses the conceptual distinction, which is fundamental to grasping the purpose and value of interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9fbe5a80-4649-445d-8bf2-a4c4795d8571', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because understanding how to define the basic structure of a class is essential before learning how to apply naming conventions to it.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9fbe5a80-4649-445d-8bf2-a4c4795d8571', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because distinguishing between classes and objects provides the conceptual understanding of what a class represents, which is crucial for applying descriptive and meaningful naming conventions.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1db3b49c-dfef-4855-94df-45b59047fa25', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite because it covers the fundamental distinction between a class''s public interface and its internal implementation, which is essential for assessing how well a design separates these concerns.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1db3b49c-dfef-4855-94df-45b59047fa25', '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'This KC is a prerequisite because understanding how to define an interface is foundational to evaluating designs that utilize interfaces.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1db3b49c-dfef-4855-94df-45b59047fa25', '6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'This KC is a prerequisite because knowing how to implement an interface is crucial for understanding the implementation side of the interface-implementation separation.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1db3b49c-dfef-4855-94df-45b59047fa25', 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', 'This KC is a prerequisite because it explains the application of the interface/implementation paradigm to achieve loose coupling, which is a core criterion for evaluating the quality of a software design as mentioned in the main KC.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because understanding how to define the basic structure of a class is essential before documenting its overall purpose and function.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', 'f8e293fe-8bdf-44cc-9a73-412520a80e62', 'This KC is a prerequisite because documenting a class''s internal logic requires knowledge of how to define and identify its attributes (object data).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because commenting on the behavior and functionality of a class''s components necessitates understanding how to define and identify its methods (object behaviors).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '469ed793-d86f-4dff-b2fc-70b77e83a0eb', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the fundamental distinction between classes (blueprints) and objects (instances) is essential before learning about attributes that define an object''s state.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '469ed793-d86f-4dff-b2fc-70b77e83a0eb', '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'This KC is a prerequisite because learners must understand how to declare the basic structure of a class before they can define attributes within it.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite because it covers understanding and applying access modifiers (like ''private''), which are explicitly mentioned as part of declaring and controlling the visibility of class attributes.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7bd074f2-04d0-462c-8d0d-a53ac985e077', '148f7ad4-89e4-4454-8acb-7041c7876824', 'This KC is a prerequisite because understanding the fundamental distinction between a class (blueprint) and an object (instance) is essential before designing the public interface for a class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7bd074f2-04d0-462c-8d0d-a53ac985e077', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because designing public class interfaces requires knowing how to define methods, which represent the behaviors offered by a class.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7bd074f2-04d0-462c-8d0d-a53ac985e077', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite because understanding public and private access modifiers is crucial for defining which methods form the public interface and which remain internal implementation details.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '7bd074f2-04d0-462c-8d0d-a53ac985e077', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite because designing public class interfaces is fundamentally about separating the external view (interface) from the internal workings (implementation).');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '4d11f382-1287-4e52-b80f-d2dc1e655725', '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'This KC is a prerequisite because it covers the fundamental skill of defining methods within a class, which is necessary before learning to define private methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '4d11f382-1287-4e52-b80f-d2dc1e655725', 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'This KC is a prerequisite because it introduces the concept of access modifiers like private and public, which are essential for understanding and implementing private class methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '4d11f382-1287-4e52-b80f-d2dc1e655725', '2ed95544-8955-4b79-abda-d09f8d9499d1', 'This KC is a prerequisite as understanding the distinction between a class''s public interface and its internal implementation is key to grasping the purpose of private methods.');
INSERT INTO public.module_kc_prerequisite (module_id, kc_id, prerequisite_kc_id, rationale) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '4d11f382-1287-4e52-b80f-d2dc1e655725', '1323bbe7-116c-4fb1-b059-b8a07e0916ca', 'This KC is a prerequisite because implementing private methods is a direct application of encapsulation principles, which aim to hide internal logic and restrict direct access.');


--
-- Data for Name: module_lesson_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'dcccc6fc-222e-4ecd-be3a-068acc1201f7', 1);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '8b0e0b53-1138-4984-82a0-c68171222de0', 1);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'df259a57-6410-451f-9750-6354d522d76d', 2);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'c5c232d1-7640-42d8-9517-795d094190fa', 3);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '431920e5-a5df-4a0f-abf2-8d8dd6a22ea9', 4);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '85d89de7-6e44-4910-804c-17dfc10cb0be', 5);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'bee88569-4567-4b2e-89ec-de60bc596bc0', 6);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1b6f4bd4-6af5-4095-ad7f-69978772bc3b', 7);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'd20feaf3-2abc-418e-8986-c2d5a4b4c725', 8);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'df7f776a-f96b-4347-be09-88d458ced907', 9);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'a51e1cf9-daab-42f7-8b65-754de29300b5', 10);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '1f07b6a7-f210-4983-91cb-a3abbbc25c46', 11);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'ff7627f7-e36a-4c23-abce-bf5bc95087db', 12);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '20b3450a-baaa-413d-b7ea-c598874439f8', 13);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '9a4f0331-fe2f-4689-826d-4fd87dc34225', 14);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '41c441dd-1cf1-41b8-a1a3-d182683f78fa', 15);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'f6fedc4e-809f-4e68-a478-c6597593b6b6', 16);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'fbc5a89e-8d85-4408-87c9-ed75e2e13e53', 17);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '344a3249-fb11-4666-8fec-1df09e0553c4', 18);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', 'cded15bd-d98e-4da6-accc-0cdcd72086a8', 19);
INSERT INTO public.module_lesson_mapping (module_id, lesson_id, order_index) VALUES ('04fbd0db-a1a9-462a-bc4d-fff1fb4d5930', '3de328c4-0659-43e9-b5e8-7882f6b02878', 20);


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f7fd4704-fd08-412d-b755-f9462210bfac', 'WRITTEN', 'Show one class extending another and using its methods.', 'The subclass can use inherited methods from the superclass.', 'Provide a simple Java code example, in Markdown format, that demonstrates an **''is-a'' relationship** between two classes. Explain how your example illustrates this relationship.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('32c9b366-417a-4b4c-b717-ecdfde1e87d3', 'MULTIPLE_CHOICE', 'Think about what a subclass must implement from an abstract superclass.', 'A subclass can perform all actions of the superclass and provide its own implementations for abstract methods.', 'If Square inherits from an abstract Shape class (establishing an ''is-a'' relationship), what is necessarily true about the Square class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('7f9befc5-45dc-4f2b-9a6b-9de14edae151', 'WRITTEN', 'Think about how a subclass represents a specific type of a superclass.', 'An ''is-a'' relationship allows the subclass to inherit behavior and attributes from its superclass.', 'Explain, in Markdown format, what the **''is-a'' relationship** signifies in Object-Oriented Programming and why it is fundamental to inheritance.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('07a34361-54aa-456e-8e3e-f33ab7e54baf', 'MULTIPLE_CHOICE', 'Consider how one class can be a more specific version of another class.', 'An ''is-a'' relationship means a subclass represents a type of its superclass.', 'In Object-Oriented Programming, what does an **''is-a'' relationship** primarily represent?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a5ac4e35-eac4-4e71-bee8-4eddd314b4ce', 'WRITTEN', 'A superclass is the general class; the subclass is the more specific one.', 'Think of a `Vehicle` superclass and a `Car` subclass.', 'Explain the difference between a **superclass** and a **subclass** in Markdown format, including a small code example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('44504bb0-41e4-4434-a968-5714eb084a44', 'WRITTEN', 'Think of a general class with methods that multiple subclasses can share.', 'Example: `Vehicle` and `Car`, `Bike`.', 'Provide an example where **inheritance improves code reusability** in Markdown format.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('642c4a8d-7295-4822-84cd-6c589067b053', 'MULTIPLE_CHOICE', 'Think about how a class indicates it wants to inherit from another.', 'It comes right after the subclass name.', 'Which keyword is typically used in Java to establish inheritance?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('feec1a5d-9095-482d-861a-a698b8b0827c', 'MULTIPLE_CHOICE', 'Think about what code reuse allows you to do with existing classes.', 'Inheritance allows a subclass to use or extend the behavior of a superclass.', 'What is the primary purpose of **inheritance** in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('ffd422dc-dbc7-4a41-a002-91aa03e70dd9', 'MULTIPLE_CHOICE', 'Focus on what a subclass can do with inherited properties.', 'Consider overriding and adding new methods.', 'Which statement about subclasses is true?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8d256539-243c-47a4-a5cf-eed9f5eacfd3', 'WRITTEN', 'Think about the purpose of abstraction: hiding complexity and providing a common interface.', 'An abstract class cannot be instantiated directly, and abstract methods have no body. Why would a developer choose this approach?', 'Explain what an **abstract class** and an **abstract method** are in Object-Oriented Programming, and why they are used. Include Java code snippets to illustrate.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3ade7bbc-8cbc-4e63-8938-1f3ceb75f941', 'WRITTEN', 'Remember that a concrete subclass *must* provide an implementation for all inherited abstract methods [user query, 128].', 'Think about what specific action a `Car` takes to `start()`, and how this fulfills the contract defined by `Vehicle` without revealing all internal mechanisms.', 'Given the following abstract `Vehicle` class with an abstract `start()` method, provide a Java code snippet for a concrete `Car` subclass that properly implements the `start()` method. Explain how this demonstrates **abstraction**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0003e2a5-2711-49ca-95ed-a361b61bc418', 'MULTIPLE_CHOICE', 'It''s the keyword that signifies something is incomplete and needs to be implemented elsewhere.', 'It''s used when a concept cannot be directly instantiated as an object.', 'Which keyword is used in Java to declare a class or method as **abstract**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('73728c43-0dbd-4de1-8e21-65a519874c83', 'MULTIPLE_CHOICE', 'Think about simplifying complex systems for users.', 'It''s about what the user *sees* (essential features) versus what is *hidden* (complex implementation).', 'What is the primary purpose of **abstraction** in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('35c97850-9c82-42fa-917f-c8ee852c54c4', 'MULTIPLE_CHOICE', 'Think about the ''contract'' that an abstract class imposes on its subclasses.', 'What must a subclass do with any abstract methods it inherits to be fully functional?', 'Which statement is true regarding a concrete subclass that extends an **abstract class** in Java?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('02785fc6-3f61-4ffd-8b2b-0c55d72a20e0', 'MULTIPLE_CHOICE', 'Look for one class extending another to form a specialized type.', 'An ''is-a'' relationship is shown when a subclass inherits behavior from a superclass.', 'Which of the following best exemplifies an **''is-a'' relationship** in Java?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('ea50d206-0377-4a0d-9874-64993cc01d6f', 'WRITTEN', 'Think about how multiple subclasses can share common behavior from a superclass.', 'Shared methods in the superclass can be reused by all subclasses without rewriting code.', 'Discuss the **advantage of using ''is-a'' relationships** in Object-Oriented design, specifically focusing on how it supports code reusability.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('fe1cf1ab-2d94-4ff9-b4b4-451a50dc2024', 'MULTIPLE_CHOICE', 'Think about the purpose of an abstract method and what it lacks in the abstract class.', 'An abstract method defines a behaviour that is left ''undefined'' in the superclass.', 'In Object-Oriented Programming, if an abstract class declares an **abstract method**, what must a concrete subclass do with that method?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('dcb1de41-8588-483d-9e02-77715c9a95c5', 'MULTIPLE_CHOICE', 'Recall how a subclass indicates inheritance and how it provides a method''s implementation.', 'The `extends` keyword is used for inheritance, and concrete methods have a body, even if empty.', 'Consider an abstract class `Shape` with an abstract method `draw()`. Which of the following code snippets correctly demonstrates a concrete `Circle` class fulfilling this contract?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c1504e54-0457-462b-97ca-5d6f3a42f676', 'WRITTEN', 'Consider what an abstract method *defines* versus what it *provides*.', 'Think about how abstract methods relate to subclasses being ''forced'' to provide certain functionality.', 'Explain, in Markdown format, the **purpose of abstract methods** in an abstract class and why they are fundamental to establishing a ''contract'' for concrete subclasses.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('79f145b2-3430-443d-a11b-ed2522d1a3df', 'MULTIPLE_CHOICE', 'Think about the relationship between an abstract superclass and its concrete subclasses regarding method responsibilities.', 'Consider what polymorphism allows with abstract methods.', 'Which of the following statements about **implementing abstract methods** is true, based on Object-Oriented Programming concepts?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('9f0cdb7c-0837-479d-949e-3e68500974b1', 'WRITTEN', 'Define an abstract class with an abstract method first, then a subclass that inherits and implements it.', 'Show how the subclass uses the `extends` keyword and provides a method body for the abstract method.', 'Provide a simple Java code example, in Markdown format, that demonstrates a concrete class implementing an abstract method from its abstract superclass. Explain how your example illustrates the concept of ''implementing abstract contracts''.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c94e5bb0-f813-4bfb-8bda-6fcadb1e1f0f', 'WRITTEN', 'What happens if an abstract method is not made concrete by its subclass?', 'Consider the rules for abstract classes and direct instantiation.', 'Discuss the **consequences** of a concrete class inheriting from an abstract class but failing to provide implementations for all of its abstract methods. Refer to the information provided in Chapters 1-4.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('7805bbf6-6a55-4dd9-abc3-32182da43799', 'MULTIPLE_CHOICE', 'Consider what an object is designed to *do*.', 'Behaviors are actions or operations an object can perform.', 'In Object-Oriented Programming, what do **object behaviors** primarily represent?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3c68f975-fa03-45a7-ba24-d832077c6b3f', 'MULTIPLE_CHOICE', 'Think about how changes in a system can be managed without disrupting users.', 'An example is a ''Print'' button: users do not need to know the printer model or internal algorithms to use it.', 'Why is it beneficial to **hide the implementation details** of a user interface from the user?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('154bbdc2-abff-4c83-bd3c-4cdc1ec7e1ca', 'WRITTEN', 'Focus on how abstraction simplifies interaction and allows for underlying changes.', 'Consider how a user interacts with a common device or software feature without needing to know its internal mechanics.', 'Explain how **abstraction** contributes to designing **flexible and intuitive user interfaces**. Provide an example to illustrate your explanation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('feb4a19d-55b1-4e3d-8614-17cc940d2f67', 'WRITTEN', 'Think about the implications of exposing too much versus just enough functionality.', 'Reducing what''s publicly accessible can limit the impact of future changes.', 'Describe the **''minimal public interface''** principle in class design and explain how it supports creating **adaptable interfaces**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0d5f0624-1d15-4004-87e9-3d7743f90e8c', 'WRITTEN', 'Think about what a user *does* with a smartphone.', 'Users initiate actions, and these actions become the object''s methods.', 'Explain how to determine the **necessary behaviors (methods)** for a `Smartphone` object from the perspective of a typical user, providing at least two examples of such behaviors.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('eb79b12f-a85f-475f-816e-bdde79fe19f4', 'MULTIPLE_CHOICE', 'Consider external factors that can impose limitations on a system or object.', 'These are often related to hardware, network, or other external conditions.', 'Which of the following best describes an **environmental constraint** in the context of object design?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('973ab281-fd9b-4760-a64c-f49a9b59b314', 'WRITTEN', 'Think about a primary action a user expects from a smart light and something outside the light itself that could affect it.', 'User needs become methods, and external limitations become design considerations.', 'Imagine you are designing a `SmartLight` object for a home automation system. Using the principles of identifying user needs and considering system limitations, propose one core **behavior (method)** for the `SmartLight` and one potential **environmental constraint**, explaining how each would be translated into the object''s design.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('515d04cd-f8ec-4910-ac7f-721d95562b65', 'WRITTEN', 'Consider external factors that might limit a smart device in a home setting.', 'Think about what external resources a thermostat relies on and what happens if they are absent or limited.', 'Describe how an **environmental constraint** could impact the design and functionality of a `SmartThermostat` object intended for a home, providing a specific example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e1ed95f4-7a5c-4fb1-9195-73ee1a7fd8a5', 'MULTIPLE_CHOICE', 'Consider who or what might interact with the class by sending it messages or receiving services.', 'Users are not just human end-customers but also other software components or internal roles.', 'When designing a class interface, which of the following best describes what is meant by a ''user'' of that class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d1c3ed01-5297-4f3e-8a60-5400867c65cd', 'MULTIPLE_CHOICE', 'Think about all possible entities that would send a message or request a service from the `PaymentProcessor`.', 'Consider both external interactions (like a customer) and internal system components.', 'For a `PaymentProcessor` class, which of the following would be considered a ''user'' for interface design?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('35334e96-d0bb-4935-8f22-e968575056b4', 'WRITTEN', 'Consider who would control the light, who would monitor its state, and what other systems might interact with it.', 'Think about human users, other devices or software, and any internal roles responsible for the light’s functionality.', 'Explain, using a hypothetical `SmartLight` class that controls a room''s lighting, who its various ''users'' might be and why identifying them is crucial for its interface design.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('46ab0646-3b78-490d-81c5-9435a5861a90', 'MULTIPLE_CHOICE', 'Consider what happens if some users'' needs are overlooked during design.', 'Think about the impact on the functionality and usability of the final system.', 'Why is it crucial for effective interface design to identify *all* users of a class or system?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('be8aa773-2d03-42a5-8ad3-ec04bf5f022c', 'WRITTEN', 'Think about how a printer integrates into a larger computing environment beyond direct human interaction.', 'Consider software components that prepare documents for printing or manage print jobs.', 'Consider the design of a `Printer` class. Beyond a human user, what other types of ''users'' might this class have, and what specific services would they expect from its interface?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('57b54c7a-c7ef-47c2-8bf2-aa351abbf02c', 'WRITTEN', 'Consider what a driver prioritizes (e.g., simplicity, real-time alerts) versus what a mapping service provides (e.g., detailed route data, traffic updates).', 'Think about how core functionality might be exposed differently or how the system''s overall goal needs to balance these needs.', 'In the context of designing an interface for a `NavigationSystem` class in a car, discuss how conflicting requirements from different user types (e.g., driver vs. mapping service) could arise and how understanding all users helps manage these conflicts.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c027d03c-5c65-47f6-9a13-a418e6b792b6', 'MULTIPLE_CHOICE', 'Consider what external code needs to know to *use* a class.', 'It''s about *what* the class does for others, not *how* it does it.', 'What does a class''s **public interface** primarily define in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('9f2604be-124c-451d-8d5b-983f80a98751', 'MULTIPLE_CHOICE', 'Think about the internal workings and hidden details of a class.', 'It''s about *how* the class achieves its defined services, not *what* services it offers.', 'In Object-Oriented Programming, what does the **implementation** of a class primarily represent?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('ad35ba58-7918-4923-a4cf-9b7e963d1961', 'WRITTEN', 'Define each term individually and then explain how they relate to independent components.', 'Think about how a ''black box'' approach to designing components benefits system structure.', 'Explain the concept of **separating interface from implementation** in Object-Oriented Programming and describe its importance for **modularity**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a117a00a-194f-493c-90dd-036707b26568', 'MULTIPLE_CHOICE', 'Consider how changes to internal workings affect external users.', 'This separation promotes independent development and modification, especially regarding future updates.', 'Which of the following is a primary **advantage** of separating a class''s public interface from its internal implementation?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('bfc5d85e-b231-4037-a1f6-9142e7fb50bd', 'WRITTEN', 'Consider the implications of direct, uncontrolled access to attributes from outside the class.', 'Think about data control, validation, and the purpose of accessor (getter/setter) methods.', 'Using a Java code example, explain why a class''s **attributes** are typically part of its **private implementation** rather than its public interface.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('eacbbb4f-993c-4307-8144-552cfdfaeff9', 'WRITTEN', 'Imagine a simple service, like a ''calculate tax'' function. If the tax rules change, how does separation help?', 'Focus on how external code (users of the service) remains unaffected.', 'Describe how the separation of interface and implementation benefits **maintainability** when the underlying logic of a method needs to change. Provide a simple scenario.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('ca327a31-5a12-45be-9974-814191640a2b', 'MULTIPLE_CHOICE', 'Consider where the primary identifier for a blueprint is usually placed.', 'The very first piece of information you see when looking at a class diagram is its name.', 'In a UML Class Diagram, which section typically contains the **name** of the class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('619f0ba2-97b9-413d-9e97-d1f2c3d273ca', 'WRITTEN', 'Think about what kind of information attributes store for an individual object.', 'Attributes essentially define the characteristics or properties that give an object its unique data.', 'Explain the role of **attributes** within a class in a UML Class Diagram, and why they are important for understanding an object''s state.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c4715bd3-517b-425d-9bcf-f167262d5277', 'MULTIPLE_CHOICE', 'Think about what kind of information `name` and `address` represent for an object.', 'These items describe the characteristics or data that an object holds.', 'Consider a UML Class Diagram for a `Person` class. Which section is used to define the `name` and `address` of a person?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('eafc849b-8947-42f2-a389-1af9984448c2', 'MULTIPLE_CHOICE', 'Consider what these represent in terms of an object''s capabilities or actions.', 'These are the functions or procedures that an object can perform.', 'In a UML Class Diagram for a `Car` class, where would you typically find operations like `startEngine()` or `accelerate()`?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('65c484a7-d54d-4cf1-9d19-9a63290029ea', 'WRITTEN', 'Consider what actions an object can perform.', 'Methods are the executable parts of a class that define its functionality.', 'Describe what **methods** signify in a UML Class Diagram, and how they relate to an object''s behavior.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('ad557157-7408-48c4-9818-2671d40934eb', 'MULTIPLE_CHOICE', 'Consider simplifying the user''s view of a complex system.', 'Abstraction emphasizes ''what'' an interface does, not ''how'' it does it.', 'When designing user interfaces, applying **abstraction** primarily involves focusing on what?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d9a55a8d-727b-4159-b707-eedf74787ef0', 'MULTIPLE_CHOICE', 'Think about how changes in a system can be managed without disrupting users.', 'An example is a ''Print'' button: users do not need to know the printer model or internal algorithms to use it.', 'Why is it beneficial to **hide the implementation details** of a user interface from the user?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('985cc2aa-9595-4ba0-a70a-2451b5ddc8a6', 'WRITTEN', 'Consider what is ''exposed'' to external users versus what is ''hidden'' internally.', 'The interface tells you ''what'' a method does and ''how to call it'', while the implementation tells you ''how'' it does it.', 'Differentiate between the **interface** and the **implementation** of a method within a class, giving a simple Java example of a method''s interface.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('4f0cbbc6-c474-4e0c-9320-b296775bc1b2', 'WRITTEN', 'Focus on how abstraction simplifies interaction and allows for underlying changes.', 'Consider how a user interacts with a common device or software feature without needing to know its internal mechanics.', 'Explain how **abstraction** contributes to designing **flexible and intuitive user interfaces**. Provide an example to illustrate your explanation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a34bbf1b-b3df-4738-a4e4-6f29b0caf125', 'WRITTEN', 'Consider what is ''exposed'' to external users versus what is ''hidden'' internally.', 'The interface tells you ''what'' a method does and ''how to call it'', while the implementation tells you ''how'' it does it.', 'Differentiate between the **interface** and the **implementation** of a method within a class, giving a simple Java example of a method''s interface.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c7a789dd-c64a-4153-901f-bc24d9762b23', 'WRITTEN', 'Think about the implications of exposing too much versus just enough functionality.', 'Reducing what''s publicly accessible can limit the impact of future changes.', 'Describe the **''minimal public interface''** principle in class design and explain how it supports creating **adaptable interfaces**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('1ebdbf0d-2817-4628-8784-7a081f246251', 'MULTIPLE_CHOICE', 'Think about what parts of a class are visible and accessible to other objects.', 'An interface acts as a contract, outlining what services a class provides to its users.', 'In object-oriented design, what is the primary role of an **interface** when defining a class for external interaction?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('05ca5bdb-7bc7-4b08-9ef8-e97179de990e', 'MULTIPLE_CHOICE', 'Consider simplifying the user''s view of a complex system.', 'Abstraction emphasizes ''what'' an interface does, not ''how'' it does it.', 'When designing user interfaces, applying **abstraction** primarily involves focusing on what?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c1c917f6-47e9-43d6-9644-543511643a7e', 'MULTIPLE_CHOICE', 'Think about what parts of a class are visible and accessible to other objects.', 'An interface acts as a contract, outlining what services a class provides to its users.', 'In object-oriented design, what is the primary role of an **interface** when defining a class for external interaction?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('1d14c4fb-d009-4c10-9d82-36d79e9d7642', 'WRITTEN', 'Consider what is ''exposed'' to external users versus what is ''hidden'' internally.', 'The interface tells you ''what'' a method does and ''how to call it'', while the implementation tells you ''how'' it does it.', 'Differentiate between the **interface** and the **implementation** of a method within a class, giving a simple Java example of a method''s interface.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('efe8be5f-f686-4710-aac0-666b9ef5b86e', 'WRITTEN', 'Think about the implications of exposing too much versus just enough functionality.', 'Reducing what''s publicly accessible can limit the impact of future changes.', 'Describe the **''minimal public interface''** principle in class design and explain how it supports creating **adaptable interfaces**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8b39feab-7d75-4c8d-b1cd-177a6f23ecdf', 'MULTIPLE_CHOICE', 'Consider simplifying the user''s view of a complex system.', 'Abstraction emphasizes ''what'' an interface does, not ''how'' it does it.', 'When designing user interfaces, applying **abstraction** primarily involves focusing on what?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a58e3c86-b89e-4c45-b5d1-ffd972671849', 'WRITTEN', 'Focus on how abstraction simplifies interaction and allows for underlying changes.', 'Consider how a user interacts with a common device or software feature without needing to know its internal mechanics.', 'Explain how **abstraction** contributes to designing **flexible and intuitive user interfaces**. Provide an example to illustrate your explanation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e57fa057-585c-4abb-95ec-320343fb6cf5', 'MULTIPLE_CHOICE', 'Think about how changes in a system can be managed without disrupting users.', 'An example is a ''Print'' button: users do not need to know the printer model or internal algorithms to use it.', 'Why is it beneficial to **hide the implementation details** of a user interface from the user?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('05451828-5f5f-4066-b83b-f22af4a617f7', 'MULTIPLE_CHOICE', 'Think about what parts of a class are visible and accessible to other objects.', 'An interface acts as a contract, outlining what services a class provides to its users.', 'In object-oriented design, what is the primary role of an **interface** when defining a class for external interaction?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('ff5a4a81-fdab-479b-9424-e3e9b5801553', 'MULTIPLE_CHOICE', 'Think about the example given in the description: ''Take me to the airport'' versus ''Turn right, then left''. Which one is more general and widely applicable?', 'An abstract interface defines *what* an object can do, rather than *how* it does it. This broad definition supports varied implementations.', 'Which of the following best describes an **abstract interface** in Object-Oriented Programming, as it relates to reusability?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('34d82057-a293-4f9a-86ef-df067ca2909e', 'MULTIPLE_CHOICE', 'Consider what happens to other parts of a system if an interface unexpectedly changes.', 'A consistent interface means that classes interacting with it don''t need to be updated, even if the underlying details are modified.', 'In the context of designing reusable Object-Oriented classes, why is it beneficial for an interface to remain **consistent** even when its internal implementation changes?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('cde20b6e-eea6-4e55-b944-1df6fadb2528', 'MULTIPLE_CHOICE', 'Look for a design that defines ''what'' a class does, not ''how'' it does it, and can be implemented in various ways.', 'Consider interfaces or abstract classes that declare methods without providing a concrete implementation.', 'Which of the following Java code snippets best represents the design of an **abstract interface** for a reusable Object-Oriented class, according to the principle of reusability?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e5c0f586-2eff-4f41-abdc-09c9b61e689e', 'WRITTEN', 'Consider how a general instruction can be applied in more situations than a specific one.', 'Think about the flexibility gained when you define a high-level goal rather than detailed, step-by-step instructions.', 'Explain how designing **abstract interfaces** (e.g., ''Take me to the airport'') instead of concrete ones (e.g., ''Turn right, then left'') promotes **higher reusability** in object-oriented classes.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('2705f7df-f1f1-4c99-89a9-b97639d0cc30', 'WRITTEN', 'Define an interface with a general method, then have two different classes implement it in their own ways.', 'Show how code interacting with the interface doesn''t need to change, even if the underlying object''s implementation differs.', 'Provide a simple Java code example, in Markdown format, that demonstrates an **abstract interface** designed for reusability. Explain how your example allows for diverse, specific implementations while maintaining a consistent interface for its users.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c2204b5d-e5dd-4d7c-9751-6f2a071f8200', 'WRITTEN', 'Think about the separation of ''what'' (interface) and ''how'' (implementation).', 'Consider how external code interacts with a class and what it needs to know versus what it doesn''t.', 'Explain how designing an abstract interface helps to **protect against internal implementation changes** while maintaining the usability of an Object-Oriented class.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('fb960709-a4bd-41c0-8910-608b719b65af', 'WRITTEN', 'Consider what happens if you design an interface around a very narrow or specific need.', 'Think about how a broad, high-level understanding of user needs leads to more adaptable solutions.', 'Discuss the importance of identifying **general user goals** when designing abstract interfaces for Object-Oriented classes, particularly in ensuring the interface can be implemented in diverse, specific contexts.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('edbab82e-1826-4efb-b07f-f7d684d9bc50', 'MULTIPLE_CHOICE', 'Think about who will actually interact with the object and what they need from it.', 'The user''s needs dictate the functionalities required for the object to be useful.', 'Why is it crucial to determine an object''s necessary behaviors **from the perspective of its identified users** during design?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('98d159c6-bbca-4f86-ad25-74d43e7deb31', 'WRITTEN', 'Recall the three main sections of a UML Class Diagram and what each section represents.', 'Think about where the class''s identity, its data, and its actions are typically placed.', 'Imagine you are designing a UML Class Diagram for a `Book` class. This class needs to store its `title` (a string) and `numberOfPages` (an integer), and it should be able to perform an operation to `openBook()`. Describe, in Markdown format, how these elements would be structured within a basic UML Class Diagram for the `Book` class.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8aa229f7-ddbd-48c5-98df-b71a16f1790d', 'WRITTEN', 'Think about what a method enables an object to *do*.', 'Consider how methods, alongside attributes, help an object manage its own state and actions.', 'Explain what a **method** signifies within a class in object-oriented programming, and describe how it contributes to an object''s **functionality** and **encapsulation**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f7c8818a-70da-461a-8cd6-7bcd9ec592f2', 'WRITTEN', 'Think about how comments help someone who didn''t write the code.', 'Consider both the immediate clarity and long-term usability of the code.', 'Explain the importance of **comments** in understanding a class''s function and facilitating its maintenance.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8946a048-2cb1-45a2-8cc6-14dd000710d1', 'MULTIPLE_CHOICE', 'Consider the two key qualities mentioned for good interface design.', 'They should reveal only what is absolutely necessary and nothing more.', 'According to proper design principles, how should **public class interfaces** be designed?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('80e0e991-1c4f-4e10-8998-2c913bda0173', 'MULTIPLE_CHOICE', 'Think about what an object *does*.', 'Methods are the executable parts of an object, defining its capabilities.', 'What is the primary purpose of a **method** within an object-oriented class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('88d37ef1-2aa8-462c-91d7-58e1dbb977b9', 'MULTIPLE_CHOICE', 'Consider why documentation is important for understanding code.', 'Comments clarify what the code does and why it was written in a certain way.', 'What is the primary purpose of writing **comments** within a class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a22216a5-7c02-4dbd-b627-99057f2b9299', 'MULTIPLE_CHOICE', 'Think about what these methods allow a class to do for external users.', 'Consider how they define the services a class makes available.', 'What is the primary role of **public interface methods** within a class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3633fbab-bcd9-4950-8d15-a33fc79d27f3', 'MULTIPLE_CHOICE', 'Consider the parts of an object that describe what it *can do*.', 'These components are sometimes called operations or functions.', 'In object-oriented programming, an object''s **behaviors** are typically defined and contained within which component of its class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f3e2cd90-912c-44c3-998a-e6b3bf38511d', 'MULTIPLE_CHOICE', 'Recall the syntax for comments that can span multiple lines.', 'Look for the pair of symbols that mark the beginning and end of a block comment.', 'Which comment syntax is specifically used for **multi-line comments** in Java and similar languages, and how is it correctly terminated?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b1adc3b9-38a9-4028-aad6-251108592819', 'MULTIPLE_CHOICE', 'Think about how you make an object''s functionality visible to the outside world.', 'This keyword designates an interface that other objects can use to send messages.', 'When defining a method in Java, which access modifier is typically used to allow other objects to invoke that method?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d068acdf-93d0-4b60-aa34-acad18893d24', 'WRITTEN', 'Consider how each type of comment starts and ends, and what happens if a closing tag is missing.', 'Think about how the compiler interprets an unterminated multi-line comment.', 'Describe the difference in **syntax and typical usage** between **single-line (`//`)** and **multi-line (`/* */`)** comments. Include a specific issue that can arise if a multi-line comment is not properly terminated.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f50a4a8f-aa6a-41ec-b276-db271e9fa419', 'WRITTEN', 'Recall the basic syntax for defining a public method inside a Java class.', 'The method should represent an action a dog performs.', 'Provide a simple Java code snippet for a `Dog` class that includes a method named `bark()` that prints "Woof!". Explain how this `bark()` method defines a behavior for a `Dog` object.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('967d8f4c-60e0-40ef-9795-217aee6dbc6a', 'WRITTEN', 'Remember the specific characters for each comment type.', 'Place the single-line comment next to an attribute and the multi-line comment before a method.', 'Provide a Java code snippet for a simple `Car` class. Include both a **single-line comment (`//`)** explaining an attribute and a **multi-line comment (`/* */`)** explaining the purpose of a method. Ensure both comments are syntactically correct.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('382dbf51-54df-428c-a443-dc3f00368652', 'WRITTEN', 'Think about the benefits of not exposing too much detail, both for users and for future maintenance.', 'Consider how hiding complexity improves usability and robustness.', 'Explain **why** public class interfaces should be **minimal** and **keep internal workings hidden**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c2d99813-7881-4e6d-98c1-ed22d048f251', 'WRITTEN', 'Consider what happens when too much information or control is given to external users.', 'Think about the impact on system stability and future development if internal logic is directly manipulated.', 'Describe a potential problem that can arise if a class''s **public interface methods** are **not minimal** and expose internal details.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('2eaab065-6616-46f2-9933-bc07bbf03945', 'MULTIPLE_CHOICE', 'Think about what is physically created in the computer''s memory.', 'Consider what an object truly is in relation to its class.', 'What is the primary outcome of **instantiating a class**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('1e9e28c9-9590-44bc-8971-2a29dbd2e4aa', 'MULTIPLE_CHOICE', 'Think about which one is the general definition and which is the specific entity.', 'One is a template, the other is a created item from that template.', 'Which statement accurately describes the relationship between a **class** and an **object**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e84854d9-db4b-40ef-ba4b-478218616486', 'WRITTEN', 'Consider what happens if you don''t instantiate a class.', 'Think about how you move from a general design to a specific, usable entity.', 'Explain **why understanding instantiation is crucial** when working with object-oriented programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('2bfc0ea9-d292-4009-87af-67661206e9f5', 'WRITTEN', 'Recall the Java keyword used to create new objects.', 'The general syntax is `ClassName objectName = new ClassName();`', 'Write a Java code snippet to **instantiate an object** named `myBook` from a class called `Book`.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('6157ccc8-f53d-4edf-9fab-db0e9c92c73f', 'MULTIPLE_CHOICE', 'Consider how separate objects interact with each other.', 'Think about how one object can ask another object to perform an action.', 'What is the primary function of **message sending** between objects in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('9593327a-46a8-4b5c-8f3f-c74f415152c9', 'WRITTEN', 'You will need two classes: `LightSwitch` and `Light`. The `LightSwitch` will need a method to ''flip'' or ''press'', and the `Light` will need a method to ''turn on''.', 'Consider how the `LightSwitch` object would interact with an instance of the `Light` class to achieve the desired action.', 'Provide a simple Java code snippet where a `LightSwitch` object turns on a `Light` object. Then, identify the **sender object**, the **receiver object**, and the **message content**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('eca7d620-d9fe-4e39-b83b-4e2f86a9126a', 'WRITTEN', 'Think about who initiates the communication and what information is conveyed.', 'The sender performs an action, and the message describes that action and any necessary details.', 'Explain, in your own words, the role of the **sender object** and the **message content** when objects communicate through message sending.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5dbc1405-c207-4ffe-ad5c-71633ad29aa9', 'MULTIPLE_CHOICE', 'Consider which object is being told to perform an action.', 'The receiver is the instance of the class on which the method is invoked.', 'In the Java code snippet `myCalculator.add(5, 10);`, which component represents the **receiver** of the message?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('37391e56-d241-41a5-a7dc-0337efd3b083', 'MULTIPLE_CHOICE', 'Consider how objects obtain information about other objects'' private data.', 'A ''getter'' is used to retrieve an attribute''s value.', 'What is the primary purpose of a **getter** method in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8d3c8c63-7c2a-4ae2-b052-a14f01bdcfd1', 'MULTIPLE_CHOICE', 'Think about how a setter can prevent incorrect data from being stored.', 'Consider what happens if a variable''s value needs to meet specific criteria, like being a positive number.', 'Which of the following best describes a benefit of using a **setter** method with **validation** for a private instance variable?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('fde1c387-3597-4a5c-8673-871ebb4ad75b', 'MULTIPLE_CHOICE', 'Think about the concept of protecting an object''s internal state.', 'Consider how ''data hiding'' relates to the visibility of variables.', 'Why is it considered good practice to declare instance variables as **private** when using getters and setters in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('58e808a3-5068-4574-8363-08b530c39c85', 'WRITTEN', 'Think about what ''encapsulation'' means and how visibility modifiers (private/public) play a role.', 'Consider how direct access to data can be risky, and how methods can mitigate that risk.', 'Explain how using **private instance variables** combined with **public getter and setter methods** contributes to the principle of **encapsulation** in Object-Oriented Programming. Provide one specific benefit this approach offers.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('1aaabfab-be55-4b3d-b54e-0aff1e187e69', 'WRITTEN', 'Remember to declare the `grade` variable as `private`. Your setter should use an `if` statement for validation.', 'The getter will simply return the `grade`. Think about how the `private` keyword and the conditional logic in the setter enforce the requirements.', 'Provide a simple Java code snippet for a `Student` class that includes a **private** `grade` instance variable. Implement a **setter method** for `grade` that only allows values between 0 and 100 (inclusive), and an appropriate **getter method**. Explain how this example demonstrates **data validation** and **controlled access**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('20fa95aa-aa2a-4af1-b70c-3edb8c95c546', 'WRITTEN', 'Think about what kind of data should never change once it''s created or assigned.', 'If data is unchangeable, how does that relate to access permissions for modification?', 'In an Object-Oriented system, imagine a `Product` class with a private instance variable `productID`. Explain why `productID` might have a **getter method but no setter method**. What is the design principle being supported by this choice?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('9eacb988-f58b-494a-ab8f-c5e336824eb0', 'MULTIPLE_CHOICE', 'Consider who can directly access a member defined with this modifier.', 'Think about the scope of visibility that `private` grants to a class member.', 'What is the primary purpose of declaring a class member as `private` in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('aeb0e446-b9bc-4b30-8c4d-613ebc224f6d', 'MULTIPLE_CHOICE', 'Think about how restricting access protects the data''s quality and validity.', 'Consider what happens if an attribute can be changed arbitrarily by external code.', 'Declaring an attribute as `private` directly contributes to **data integrity** by:');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('6f6cc360-0752-4cdd-ac2f-cbe201f5c9db', 'MULTIPLE_CHOICE', 'Think about how other objects are supposed to interact with an object''s hidden data.', 'Consider the role of an interface in allowing controlled external access to an object''s functionality.', 'To enforce **encapsulation** for a `private` attribute named `balance` in a `BankAccount` class, which access modifier should be used for the methods (e.g., `deposit`, `getBalance`) that modify or retrieve its value?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('034177ba-c716-4b8b-9aa9-701cc0ce112b', 'MULTIPLE_CHOICE', 'Consider how a well-chosen name helps others understand your code.', 'Good naming conventions improve readability and maintainability.', 'What is the primary purpose of effectively naming a class in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('665f4941-f8bc-4a30-9e12-a10bfbf95f71', 'WRITTEN', 'Consider ''who'' can see and interact with members declared with each modifier.', 'Focus on the boundaries of access: within the class versus outside the class.', 'Explain the fundamental difference between `private` and `public` access modifiers for class members in Object-Oriented Programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('be10e514-f9ec-46bc-b4ef-18fad43eea8e', 'WRITTEN', 'Think about using ''getter'' and ''setter'' methods. How does preventing direct modification of the attribute uphold encapsulation?', 'The goal is to show how internal data is protected while still allowing controlled interaction.', 'Provide a simple Java code example of a `Person` class that uses `private` for an attribute and `public` for a method to access or modify that attribute, thereby demonstrating **encapsulation**. Explain why this setup enforces encapsulation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('61de4ab3-c8bf-4c2e-a44f-5aaf389c9dcb', 'WRITTEN', 'Consider the potential risks if attributes were always `public` and openly modifiable.', 'Think about how controlled access via methods helps maintain the quality and validity of an object''s internal data.', 'Discuss how declaring class attributes as `private` directly contributes to ensuring **data integrity** in Object-Oriented Programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('fa909bd7-503d-4a32-80a3-0dfabb66e28c', 'WRITTEN', 'Consider the impact of a name on someone reading your code for the first time.', 'A descriptive name acts as immediate documentation for the class''s purpose.', 'Explain why class names should be **descriptive** of what the class does. Provide a brief example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d92a884e-c219-4d88-a84f-8681d8942417', 'MULTIPLE_CHOICE', 'Think about how Java source files relate to compiled classes.', 'This rule is crucial for the Java compiler to process your code correctly.', 'In Java, what specific requirement applies to the name of a `public` class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('25d4205b-69da-4b39-9abb-adfc2dc6b4a0', 'MULTIPLE_CHOICE', 'Consider what exactly should be visible to external users of a class.', 'The focus is on providing only what is essential for interaction.', 'What is the primary principle behind designing an **absolute minimal user interface** for a class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('67f2465f-458e-448b-8de8-a90c8c09884b', 'WRITTEN', 'Consider how user input helps refine what a class should publicly offer.', 'Think about the iterative process of adding functionality based on actual needs.', 'Describe the role of **user feedback** in applying the principle of **minimal public interfaces** to a class design.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('dae4ec50-4cec-4d5f-8510-05d28dd1eb5e', 'MULTIPLE_CHOICE', 'Consider what kind of logic private methods are designed to contain and their intended visibility.', 'Think about whether they are for external use or for the class''s internal workings.', 'What is the primary role of a **private method** within a class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('894d1b82-5bdb-41b6-9f4b-d151ed535732', 'MULTIPLE_CHOICE', 'Consider which other methods within the same class typically trigger private methods to perform tasks.', 'They are part of the internal workflow, often supporting functionalities exposed to the outside.', 'How are private methods primarily invoked within a class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('69ac3d23-f357-46eb-8f3d-bf9a2fd96a0b', 'MULTIPLE_CHOICE', 'Consider how changes to internal workings affect external users of a class.', 'Think about what happens when the logic inside a method changes, but the way you call that method stays the same.', 'In Object-Oriented Programming, what is the **primary benefit** of separating a class''s interface from its implementation?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e61c5e03-8ab6-4059-8d2c-bdfcc3dcc677', 'MULTIPLE_CHOICE', 'Consider what information a user of the class truly needs to interact with it effectively.', 'Think about providing only essential services to avoid unnecessary complexity or potential misuse.', 'Which of the following best describes a **good practice** in designing class interfaces in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('232827d8-1365-4cf3-9f4e-8bb317b88d2f', 'MULTIPLE_CHOICE', 'Consider how you can interact with different specific types of objects if they share a common method defined in a superclass.', 'Polymorphism allows a single interface to represent diverse behaviours.', 'How does polymorphism, achieved through method overriding, primarily enhance an Object-Oriented Programming (OOP) system?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e99fa713-6d2d-49b8-b4d3-f2cd7b4ab625', 'WRITTEN', 'Consider how the same method call can lead to different specific actions depending on the object''s actual type at runtime.', 'Relate method overriding to a subclass providing a specific version of a superclass method, and polymorphism to treating objects of different types uniformly.', 'Explain, in Markdown format, what **polymorphism through method overriding** signifies in Object-Oriented Programming (OOP). Use the `Animal` superclass and `Dog` subclass with a `makeSound()` method as an example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c5349080-b322-4f51-b497-dcb1738dd14a', 'MULTIPLE_CHOICE', 'Think about the components that define an object.', 'These components hold information unique to each instance of a class.', 'In Object-Oriented Programming, what is the term for the data stored within an object that represents its state?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8b0ed57a-7211-4c31-b3ec-d5e15c44f356', 'WRITTEN', 'Consider defining a class with a public string attribute and then creating an object from it.', 'Remember the syntax used to refer to an object''s attribute.', 'Provide a simple Java code example demonstrating how to directly access a `public` attribute of an object named `myCar`, specifically to display its `color`. Explain how this example shows direct attribute access.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('788b54c3-e1cf-4883-b691-3783e5aafc47', 'WRITTEN', 'Both represent "has-a" relationships, but their "strength" or dependency differs.', 'Think about whether the ''part'' object can exist independently of the ''whole'' object.', 'Describe the key difference between **association** and **aggregation** as represented in UML Class Diagrams, and provide a real-world example for each.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('ce667025-d1fe-4ad1-bc40-1171d0560aa8', 'WRITTEN', 'Recall the "is-a" and "has-a" tests for different relationships.', 'Pay attention to the specific symbols (arrowhead, hollow diamond, no special symbol) and their implications for dependency.', 'Consider a UML Class Diagram showing a `Dog` class, a `Mammal` class, a `Head` class, and an `Owner` class. The diagram displays:
*   A **solid line with a hollow triangular arrowhead** from `Dog` pointing to `Mammal`.
*   A **solid line with a hollow diamond** on the `Dog` end pointing to `Head`.
*   A **simple solid line** connecting `Dog` and `Owner`.
Explain the type of relationship each line represents and its meaning in object-oriented terms.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5ea915ba-e221-46be-9b49-8308b5474914', 'MULTIPLE_CHOICE', 'Consider whether a `Car` *is a* `Engine` or *has a* `Engine`.', 'Think about how the `Engine` contributes to the `Car`''s functionality and its typical lifecycle.', 'A `Car` class needs to include an `Engine` object. Which of the following best describes the appropriate object-oriented relationship for `Car` and `Engine`, and why?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('623cccb4-d5b4-4c07-bbb3-630c195882cd', 'MULTIPLE_CHOICE', 'Think about how one class incorporates another to form a relationship.', 'Consider if the relationship is about one class being a ''type of'' another, or if it ''contains'' another.', 'What is the primary characteristic of **object composition** in object-oriented programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('edd8fd58-924f-4435-8f3b-d17bfe66ef90', 'WRITTEN', 'Look for the keyword that indicates one class is building upon another.', 'Remember that the class being extended is the more general one, providing features to the more specific one.', 'Given the following Java code snippet, identify the **superclass** and the **subclass**. Explain your reasoning.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('bd4f3fc0-16c4-4c85-b70d-f2a8438fb86c', 'MULTIPLE_CHOICE', 'Think about how functions help break down large programs.', 'Consider the benefits related to writing code once and using it multiple times.', 'What is the primary purpose of defining a function (also known as a subroutine or procedure) in procedural programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('869c489f-10db-42ae-9162-e3f850680d42', 'WRITTEN', 'Think about collaboration in a team and consistency across a project.', 'Standardised naming conventions reduce confusion and make code more predictable.', 'Discuss the importance of following **established coding standards** when naming classes in Object-Oriented Programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('55ada1c2-5737-4948-a950-37aa8531ca4b', 'MULTIPLE_CHOICE', 'Consider starting small and expanding based on need.', 'This approach helps avoid unnecessary complexity from the outset.', 'When applying the principle of **minimal public interfaces**, what is the recommended approach for initially designing a class''s methods?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('76fbb78a-6ad3-4901-b3b6-47992175ff8b', 'MULTIPLE_CHOICE', 'Think about which part is exposed and which part is hidden in a well-designed class.', 'Consider the terms ''internal implementation'' and ''external users''.', 'Which statement accurately describes the relationship between **private methods** and the **public interface** of a class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('98243b86-e221-473a-98c5-c00ae328fe1b', 'WRITTEN', 'Focus on how `TransactionProcessor` interacts with `Account`, specifically regarding the `balance` attribute.', 'Think about the concept of ''data hiding'' and what happens if internal data is manipulated directly by another object.', 'Consider the following Java code snippet:
```java
public class Account {
    private double balance;

    public Account(double initialBalance) {
        this.balance = initialBalance;
    }

    // Method to deposit money
    public void deposit(double amount) {
        this.balance += amount;
    }

    // Method to withdraw money
    public void withdraw(double amount) {
        if (amount <= this.balance) {
            this.balance -= amount;
        } else {
            System.out.println("Insufficient funds.");
        }
    }
}

public class TransactionProcessor {
    public void processWithdrawal(Account account, double amount) {
        // Direct manipulation of account''s private balance
        // Assume ''balance'' was made public for this example to compile
        account.balance -= amount; 
        System.out.println("Withdrawal processed directly.");
    }
}
```
Identify a **bad practice** in the `TransactionProcessor` class concerning interface-implementation design and explain why it is problematic, even if `account.balance` were made public.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('6819a748-cf5b-43b3-826a-97d50a102445', 'WRITTEN', 'First, define the `Animal` class with a `makeSound()` method. Then, create the `Dog` class that `extends Animal` and `overrides` `makeSound()`.', 'In your `main` method, create instances of `Animal` and `Dog`, and demonstrate calling `makeSound()` on both, possibly treating the `Dog` as an `Animal` type.', 'Provide a simple Java code example, in Markdown format, that demonstrates **polymorphism via method overriding** using an `Animal` superclass and a `Dog` subclass with a `makeSound()` method. Explain how this code illustrates the concept.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8c98acc5-84cc-49d8-912d-ff555fe516ca', 'WRITTEN', 'Think about the principles of encapsulation and data integrity.', 'Consider what happens if you need to perform validation or logic when retrieving data.', 'Explain why, in Object-Oriented Programming, using accessor methods (getters) to retrieve attribute values is generally preferred over allowing direct `public` access to those attributes.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('251883e1-d851-447c-b986-be4dcab5dcc5', 'WRITTEN', 'Focus on how objects relate when one contains or is built from another.', 'Think about how member variables (attributes) are used in a class to include instances of other classes.', 'Explain the concept of a **''has-a'' relationship** in object-oriented programming and describe how it is implemented using **object composition**. Provide a real-world example to illustrate your explanation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8e02cc12-78ee-4cea-ac09-849fecd1bb0d', 'WRITTEN', 'Focus on how one class shares its features, and another class receives and builds upon those features.', 'Think about the ''is-a'' relationship and how it applies to real-world objects like a `Dog` and a `Mammal`.', 'Explain the roles of a **superclass** and a **subclass** in object-oriented programming, and how they relate through inheritance. Provide an example to illustrate your explanation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('730403b9-5558-4ed7-9d18-5d9a4cabc6b6', 'WRITTEN', 'The return type is usually declared immediately before the function''s name.', 'Parameters are the variables defined within the parentheses in the function''s definition.', 'Given the following Java code snippet, identify the **function name**, its **parameters**, and its **return type**.

```java
public static int calculateSum(int num1, int num2) {
    return num1 + num2;
}
```');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c8bee84d-ebc6-4abb-8b4f-f38a2d2eb398', 'WRITTEN', 'Focus on the scope of `mainVar` and `inputVar`.', 'Consider if `modifyValue` is changing its own copy of the variable or the original.', 'Consider the following procedural code snippet:

```java
public class Calculator {
    public static void main(String[] args) {
        int mainVar = 10;
        modifyValue(mainVar);
        System.out.println("Value in main: " + mainVar);
    }

    public static void modifyValue(int inputVar) {
        inputVar = 20;
        System.out.println("Value in function: " + inputVar);
    }
}
```

What will be printed to the console for "Value in main:"? Explain why.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b20e6ce6-92d9-48be-aa48-f3b39ffa0705', 'WRITTEN', 'Think about how limiting interface exposure affects ease of use and potential risks.', 'Consider implications for data protection and inter-class relationships.', 'Explain two key benefits of designing a class with an **absolute minimal user interface**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('4a7a5ce9-66ed-46c0-a816-e8ae9a6ea7ea', 'WRITTEN', 'Consider a high-level action a user would request from a `Cabbie` (e.g., getting to a destination) and the smaller, internal steps required to achieve it.', 'The KC mentions examples like `turnRight()` and `turnLeft()` as private helper functions.', 'Provide a hypothetical example where a **public method** in a `Cabbie` class might call a **private method** to perform a specific, encapsulated task, ensuring the user only interacts with the public interface.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5fe02d93-b135-4d8e-9c84-f01df5cda967', 'MULTIPLE_CHOICE', 'Look for a subclass inheriting from a superclass and then providing a new implementation for an inherited method with the same signature.', 'The `extends` keyword indicates inheritance, and the overridden method in the subclass must match the superclass''s method signature.', 'Which Java code snippet best demonstrates **method overriding**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('44cd4a6c-057f-46f9-8b4c-485a3f90977c', 'MULTIPLE_CHOICE', 'Consider the diamond symbols used for "has-a" relationships in UML.', 'Think about whether the ''part'' can exist on its own or if its lifecycle is tied to the ''whole''.', 'A `Car` object contains an `Engine` object, and the `Engine` cannot exist independently of the `Car`. In a UML Class Diagram, how would this strong "has-a" relationship (composition) between `Car` and `Engine` be represented?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a324b912-609f-41a2-b23b-bf4f57b41f6b', 'MULTIPLE_CHOICE', 'Think about the class that acts as the source for inherited features.', 'This class is often referred to as the ''parent'' in an inheritance relationship.', 'What term is used to describe a class from which other classes **inherit** attributes and methods?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('754062c6-e890-40c2-8797-da3981b03891', 'MULTIPLE_CHOICE', 'Consider the syntax used to execute a function''s code.', 'Think about what you provide to the function when you want it to perform its task.', 'In procedural programming, which statement correctly describes how a function is **invoked** (called)?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c854590d-1141-42be-90b8-47a91d59afe5', 'WRITTEN', 'Think about how many different parts of a program can interact with a global variable.', 'Consider the impact on debugging and predictability of data.', 'In procedural programming, explain a significant disadvantage or problem associated with the extensive use of **global variables**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('08b82dca-6f46-4031-ae2d-cdd78ff09208', 'MULTIPLE_CHOICE', 'Consider whether data and the code that acts on it are kept together or separate.', 'Procedural programming focuses on sequences of operations, with data often accessible globally.', 'In procedural programming, how are data and operations typically organised?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0b3be419-77cf-4989-af13-efa2987a79f9', 'WRITTEN', 'Consider where data typically resides in procedural programs compared to the code that uses it.', 'Think about how this separation affects control over data access.', 'Explain the core principle of **separation of data from operations** in procedural programming and describe one significant implication of this design choice. Use Markdown for formatting.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8738dab3-6b5a-436a-ab21-c01ff9d152a4', 'WRITTEN', 'Think about the purpose of separating internal implementation from external interaction.', 'Consider how controlled access affects both the user of the class and the class''s internal state.', 'Explain why **private methods** are strictly hidden from a class''s public interface, and identify one benefit of this design principle.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b05e73a0-963f-49ea-9a47-caa551dfc530', 'WRITTEN', 'Think about how controlled access and internal changes affect system integrity and verification processes.', 'Consider how fixing a bug in an implementation benefits from this separation without impacting other parts of the system.', 'Explain how separating a class''s interface from its implementation contributes to building a more **robust** and **testable** software system. Provide a simple example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f61ab599-ae39-4ee8-923e-62a23468e185', 'MULTIPLE_CHOICE', 'Consider a situation where a subclass needs to provide a specific behaviour for a method that its superclass already has.', 'It involves a subclass defining a method with the same signature (name, parameters, and return type) as a method in its superclass.', 'In Object-Oriented Programming, what is **method overriding**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8e07dd6d-3caa-451d-ba20-63ce996bdeea', 'WRITTEN', 'Consider what happens when you introduce a *new* subclass with its own unique behaviour for an inherited method. Does existing code need to change?', 'Focus on the idea that new types can be added to the system and interact correctly with existing code written for the common superclass type.', 'Discuss, in Markdown format, how **polymorphism achieved through method overriding** contributes to the **extensibility** of an Object-Oriented Programming (OOP) system.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5a588477-68c4-4f97-b636-85daa7ce6e62', 'MULTIPLE_CHOICE', 'Think about how classes control access to their internal data.', 'There''s a specific type of method designed for reading attribute values.', 'If a `private` attribute named `age` exists within a `Person` object, which of the following is the standard object-oriented approach to retrieve its value in Java?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b6fce91c-fb87-4d57-856d-5f57704256a2', 'MULTIPLE_CHOICE', 'This relationship indicates that one class is a specialized version of another.', 'Think about the "is-a" concept in object-oriented programming.', 'In a UML Class Diagram, what type of relationship is represented by a **solid line with a hollow, unfilled triangular arrowhead** pointing from the subclass to the superclass?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('231e02a7-1000-4323-a5c7-67cd2575e870', 'WRITTEN', 'Consider how composition affects the flexibility and reusability of individual components.', 'Think about how object changes might ripple through a system when using composition versus inheritance.', 'Describe two advantages of using **object composition** for a ''has-a'' relationship compared to using inheritance.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('551de974-c017-4509-b750-9ca4486c87a1', 'MULTIPLE_CHOICE', 'Consider the class that is a more specific version of an existing class.', 'This class represents a ''type of'' the class it inherits from.', 'In an inheritance hierarchy, which term describes a class that **extends** another class and inherits its characteristics?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c6da3044-b2e9-4480-87f5-c150f9545467', 'WRITTEN', 'Think about control and predictability of data flow for each method.', 'Consider how each method impacts the reusability and testing of individual functions.', 'Compare and contrast **parameter passing** with the use of **global variables** as mechanisms for functions to exchange data in procedural programming. Discuss one advantage and one disadvantage for each approach.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('fcd44ed1-4891-4261-a81b-2b15e73b9cd1', 'WRITTEN', 'Focus on what happens when many parts of a program can change the same data.', 'Consider how object-oriented programming structures data and behavior to prevent this.', 'Discuss a major **drawback of using global data** in procedural programming and how this issue is typically addressed in object-oriented programming to improve data integrity. Use Markdown for formatting.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('309ea252-d17c-403f-92d2-c2463b94ef45', 'WRITTEN', 'Recall how to define a function with a single parameter and an integer return type. The absolute value of a negative number is its positive equivalent.', 'You can use an `if` statement to check if the number is negative and multiply it by -1 if it is.', 'Write a simple Java function named `getAbsoluteValue` that takes one integer parameter, `number`, and returns its absolute value. Include a `main` method to demonstrate how to call this function with `number = -7` and print the result.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('055064e7-0ec4-47ef-843d-52d3caa042d9', 'MULTIPLE_CHOICE', 'Consider how functions receive input data to perform their tasks.', 'Think about how data is transferred explicitly between different parts of a program.', 'What is the primary purpose of **passing parameters** to a function in procedural programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('470e26d0-b23a-4e17-8832-e3fe831f1101', 'MULTIPLE_CHOICE', 'Think about its accessibility throughout the program.', 'Consider if its scope is limited to a single function or widely available.', 'In procedural programming, what is a key characteristic of a **global variable**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('42d721b7-52d0-4bdd-a356-d5a0218cc5cd', 'MULTIPLE_CHOICE', 'Consider the fundamental constructs of structured or procedural programming.', 'Look for elements that define the flow of control and repetition in structured code.', 'Which of the following Java code snippets best represents a core characteristic of procedural programming within an application?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3db7efa0-4a2a-48bb-8db1-a5cef534a60c', 'MULTIPLE_CHOICE', 'Think about how data is shared and modified across different parts of a procedural program.', 'Consider the concept of ''global data'' in procedural programming.', 'In a procedural programming paradigm, what is a common characteristic regarding access to data by various functions?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('70e7ec3d-fd9c-40db-b124-8bb514e395c6', 'MULTIPLE_CHOICE', 'Consider whether data and the operations that manipulate that data are kept together or separate.', 'In one paradigm, they are distinct entities; in the other, they are combined within a single unit.', 'What is the **fundamental difference** in how data and behavior are organized between procedural programming and Object-Oriented Programming (OOP)?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5054929b-6006-4469-851a-83ed99b73024', 'MULTIPLE_CHOICE', 'Look for code where data and the methods that operate on that data are kept together and access is controlled.', 'Consider how private attributes are accessed through public methods.', 'Which of the following Java code snippets best demonstrates the principle of **encapsulation** and **modularity** in Object-Oriented Programming, as it contrasts with a procedural approach?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d727fb5a-5aa3-447a-a256-45f62f356f59', 'WRITTEN', 'Think about how procedural programming handles global data and how OOP''s approach is different.', 'Consider how combining data and behavior within an object (encapsulation) helps manage who can access and modify that data.', 'Explain how **data encapsulation** in Object-Oriented Programming (OOP) addresses the issue of **uncontrolled data access and integrity** commonly found in procedural programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('1cbef223-4c02-4664-98cf-90fe1489efd9', 'MULTIPLE_CHOICE', 'Recall that SRP suggests a class should have only one reason to change.', 'Consider if a class is performing multiple, independent tasks.', 'A software company wants to refactor a large, monolithic procedural application into a more modular and maintainable system using OOP principles. They decide to apply the **Single Responsibility Principle (SRP)**. Which design change best aligns with SRP?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('29ffb430-c86d-4925-9382-1f7cc5f5663d', 'WRITTEN', 'Consider the limitations of procedural programming when a system grows very large, especially concerning data and code management.', 'Think about how OOP''s approach to organizing code and data helps to reduce complexity and improve maintainability in large systems.', 'Discuss why Object-Oriented Programming (OOP) emerged as a beneficial alternative to procedural programming for managing and developing **complex software systems**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5312c739-2cae-4c6a-978f-3634c3105920', 'WRITTEN', 'Think about how employee data (e.g., hours, rate) and calculation logic would be structured in each paradigm.', 'In one, data and functions are separate; in the other, they are bundled together.', 'Provide a simple example of how a ''payroll calculation'' problem would be approached differently in **procedural programming** versus **object-oriented programming (OOP)**, specifically focusing on the organization of data and operations.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d5c9571a-9707-4d05-8367-5e6bb8ec7719', 'MULTIPLE_CHOICE', 'Consider what a class provides before you create an actual object.', 'A class defines the structure and behaviour for creating instances.', 'In Object-Oriented Programming, what does a **class** primarily represent?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3b35054e-7697-46f7-9301-ac5691b66c3a', 'WRITTEN', 'Think about what information a blueprint contains and how that relates to what a class defines for an object.', 'Your example should show a class definition and briefly explain how it guides the creation of instances.', 'Explain, in Markdown format, how a **class** serves as a **blueprint for objects**, and provide a simple Java code example to illustrate this concept.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c4604a3f-2f58-4b67-9861-fa794e41648e', 'MULTIPLE_CHOICE', 'Recall the keyword used to introduce a class definition.', 'Remember that the class body is typically enclosed in curly braces.', 'Which of the following Java code snippets correctly declares a basic class named `Bicycle`?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('123297ed-89d4-43dd-affc-3abecee73495', 'WRITTEN', 'Consider why we group related data and functions together into a class.', 'Think about how defining something once, then reusing it, impacts development efficiency.', 'Discuss the **fundamental purpose of defining a class structure** in Object-Oriented Programming (OOP), specifically focusing on how it promotes **code reusability** and **modular components**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('641d22e9-e90b-45b9-9d56-6a9f070ff803', 'MULTIPLE_CHOICE', 'Think about what information an object needs to store to be unique.', 'Attributes store data specific to each instance.', 'What is the primary role of an **attribute** in a class definition?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5988473a-c9b8-4bcc-bd43-e63330582112', 'WRITTEN', 'Consider how attributes help differentiate one object from another, even if they are from the same class.', 'Your example should show a class with an attribute and then create at least two objects with different values for that attribute.', 'Explain what an **attribute** (or data member) represents within a class definition and how it relates to individual objects. Provide a simple Python code example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('7b000bc3-6a3a-4fe4-80d1-96340d071514', 'MULTIPLE_CHOICE', 'Look for the special method used for object initialisation and how attributes are assigned within it.', 'The `__init__` method is where initial attributes are typically set using `self.attribute_name`.', 'Which Python code snippet correctly defines an attribute `colour` with the value `''blue''` for a `Car` object during its initialisation?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('07966f05-f013-4dbd-9fe8-b41160502f18', 'WRITTEN', 'Think about what "state" means for a real-world object (e.g., a car''s colour, speed).', 'Attributes allow an object to remember its specific characteristics and differ from other objects of the same type.', 'Describe why defining attributes is fundamental for storing the **state** of an object in Object-Oriented Programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('db7a1347-ee38-4496-bc72-e4b2ade0802a', 'MULTIPLE_CHOICE', 'Think about what provides the structure or definition for objects.', 'A class is a template from which objects are created.', 'In object-oriented programming, what is the most accurate description of a **class**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('991d1199-22ac-4eae-8e19-ae8239fd40c6', 'MULTIPLE_CHOICE', 'Consider what an object actually *is* when it''s used in a program, as opposed to its definition.', 'An object is a concrete entity created from a class.', 'Which statement accurately describes an **object** in object-oriented programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('4a5fa5c3-abf0-4c04-817f-232c1d3783c0', 'WRITTEN', 'A class is like a design; an object is like something built from that design. Think about what differentiates a general type from a specific entity.', 'Your example should define a class and then show how an object is created from it, noting unique data for the object.', 'Explain the fundamental conceptual distinction between a **class** and an **object** in object-oriented programming. Provide a simple Java code example to illustrate your explanation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c8a305aa-31e5-491e-a959-134250d5b766', 'MULTIPLE_CHOICE', 'Consider what happens when you tell an object to ''do'' something.', 'Methods define an object''s actions or capabilities.', 'What is the primary purpose of **invoking a method** on an instantiated object in object-oriented programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('bfd15738-1c67-4904-af32-5847677740ee', 'WRITTEN', 'Consider how this distinction helps manage complexity and enables reuse. Think about the benefits of having a ''master design'' versus many individual items.', 'Focus on the concepts of reusability and how unique states are managed across multiple instances.', 'Describe why differentiating between a **class** and an **object** is crucial for designing flexible and maintainable object-oriented systems.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0f221384-6792-4873-a41e-bcbfcbcc3bab', 'WRITTEN', 'Think about real-world items and the actions they can perform. How do you make them perform those actions?', 'Consider a remote control and a television. What does pressing a button on the remote do to the TV?', 'Explain, using an analogy, what it means to **invoke a method** on an object. Provide a simple Java code example for clarity.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('50415c83-29fd-4fcf-b5b7-0b79a5e981f1', 'MULTIPLE_CHOICE', 'Recall the standard syntax for telling an object to perform an action.', 'Think about how you typically refer to an object''s member and then trigger its function.', 'Which of the following Java code snippets correctly demonstrates **invoking a method** named `turnOn` on an already instantiated object called `myLight`?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('084f878a-7169-4b31-b2e6-01cef6130a4c', 'MULTIPLE_CHOICE', 'Think about who should directly control an object''s internal state.', 'Consider the concept of data hiding in object-oriented programming.', 'What is the primary purpose of declaring an instance variable as `private` in an encapsulated class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8fd4e29c-a7ab-49a4-a824-73388a5437e1', 'WRITTEN', 'Think about how controlled access to data prevents accidental or improper changes.', 'Consider how changes to internal implementation affect external code when data access is controlled.', 'Explain how **encapsulation** contributes to **data integrity** and **maintainability** in object-oriented programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a8aa6b6b-3b3a-402e-8e43-3e3442a4726f', 'MULTIPLE_CHOICE', 'Think about the relationship between classes that might need this common capability.', 'Consider whether the classes are related by ''is-a'' or if they simply ''behave-like-a'' something.', 'When is it more appropriate to use an **interface** instead of an **abstract class** to define a common capability?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e030ecb9-d2ae-43d6-8243-f6730a1aed24', 'MULTIPLE_CHOICE', 'Think about how encapsulation bundles data and methods and controls access to them.', 'Encapsulation is about wrapping an object''s state and behaviour together, and restricting direct access to internal components.', 'In Object-Oriented Programming, what is the primary purpose of **encapsulation**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('e0b91709-8c8d-4396-8aae-1aec1b66fdd7', 'MULTIPLE_CHOICE', 'Consider how one class can be considered a specialised version of another broader class.', 'This relationship signifies that a subclass is a kind of its superclass.', 'In Object-Oriented Programming, which relationship type is exemplified by a `Dog` being a `Mammal`?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('2b12a446-4220-4cfc-b4de-debe9ba0350a', 'MULTIPLE_CHOICE', 'Consider how these blocks affect a program when an error occurs.', 'Think about preventing unwanted program termination.', 'What is the main advantage of using `try/catch/throw` blocks for error management?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f5ce9e9d-dbe5-41fc-8a8e-bc12474bb54f', 'MULTIPLE_CHOICE', 'Think about the overall manageability and maintainability of the software design.', 'It can lead to tangled relationships and unpredictable outcomes in class hierarchies.', 'A significant consequence of using multiple inheritance in Object-Oriented Programming is that it often:');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f7459686-8887-423d-ae3d-a62fda75aed3', 'WRITTEN', 'Remember the standard syntax for calling a method on an object, especially one that takes an argument.', 'The method `activateSensor()` requires a `String` value inside its parentheses when called.', 'You are developing a simple alarm system. You have an instantiated object named `homeAlarm` from a class called `AlarmSystem`. The `AlarmSystem` class includes a method called `activateSensor()` that takes a `String` parameter representing the sensor name. Write the Java code to invoke this method on `homeAlarm` for a sensor named "FrontDoor", and explain what the execution of this line of code signifies.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('8be897a9-f1af-4b6a-a2d5-a89d3600fa12', 'WRITTEN', 'Start by defining a class with a private instance variable.', 'Create a public method named `setGrade` that takes an integer parameter and includes an `if` statement for validation.', 'Write a simple Java class named `Student` that demonstrates **encapsulation**. The class should have a `private` attribute for the student''s `grade` (an integer) and a **public method** to allow **setting** this `grade`. Include basic validation in the setter (e.g., grade must be between 0 and 100).');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('1ba54d58-cac1-4184-b94b-c06dc6b28210', 'MULTIPLE_CHOICE', 'Consider what kind of methods (with or without implementation) each type of construct can contain.', 'An abstract class can define some behaviours fully, while an interface typically cannot.', 'Which of the following statements **best describes a key difference** between an **abstract class** and an **interface** in object-oriented design?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('57707cb3-aee9-40a9-92f7-da8262a2b142', 'WRITTEN', 'Think about making an attribute private and providing a public method to access its value.', 'Consider using a ''getter'' method for a private attribute, similar to a `getName()` for a private `name` attribute.', 'Provide a simple Java code example, using Markdown format, that demonstrates **data hiding** in a class through **encapsulation**. Briefly explain how your example showcases this principle.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('7b6d54b5-fa55-4382-be72-f747bad7417e', 'WRITTEN', 'Think about how an object might contain another object as an attribute.', 'Consider a common real-world example like a `House` having a `Door`.', 'Provide a simple Java code example demonstrating a **''has-a'' relationship**. Explain how your code illustrates that one object ''has'' another, and discuss one advantage of using this relationship type in design.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('62e80cc5-e273-4dc2-8003-48cd4998e516', 'WRITTEN', 'Think about the consequences of unhandled errors for both the program and the user.', 'Consider what ''graceful error handling'' implies for program stability and reliability.', 'Describe the primary benefit of handling exceptions, such as preventing crashes, in program execution. How does this improve the software?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5de24cd6-0cc8-4243-bbf7-a8ce782489a2', 'MULTIPLE_CHOICE', 'If the goal is to share a mutable nested object (like a list) rather than creating a new one, what type of copy is that?', 'A copy that duplicates references, allowing shared modifications, is the key.', 'Consider a scenario where you have a `Student` object, which has a `name` (`String`) and a `courseEnrollment` (`List` of `Course` objects). You need to create a copy of a `Student` object where the copied student shares the exact same `courseEnrollment` list reference as the original. Which type of copy would be appropriate?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c02a0102-0ca0-47fc-bab7-624e8399194f', 'MULTIPLE_CHOICE', 'Consider what happens immediately after a new object is brought into existence.', 'The main goal is to prepare the object for use right from the start.', 'What is the **primary purpose** of a constructor in object-oriented programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('748d25c9-32a2-4d0e-80d3-c0ecd4f2bea1', 'MULTIPLE_CHOICE', 'Recall the common naming convention for methods that modify data in an encapsulated class.', 'Think about the role of public methods in controlled data access.', 'A `BankAccount` class is designed with encapsulation principles. Its `balance` attribute is `private`. Which of the following Java code snippets correctly demonstrates how an external object should interact to **deposit** funds into an instantiated `myAccount` object?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d1548300-b2e3-4ebd-81b6-90b5fa8a1bd1', 'MULTIPLE_CHOICE', 'Think about how many parent types a class can have.', 'A class can extend only one class but implement multiple interfaces.', 'Regarding inheritance, what is a key distinction between using an **abstract class** and an **interface** in Java?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3ce63e14-c932-4217-8575-a147a6586eeb', 'WRITTEN', 'Focus on an operation that inherently causes an `ArithmeticException`.', 'Ensure your `catch` block specifies the correct exception type and provides a clear message or alternative action.', 'Provide a simple Java code example using `try` and `catch` to demonstrate handling an `ArithmeticException`.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('7f2522d7-5624-4cc9-a650-fa3658c925b0', 'MULTIPLE_CHOICE', 'Think about how a deep copy handles all levels of nested objects.', 'A deep copy ensures that the new object and its entire structure are completely independent of the original.', 'Which statement best defines a **deep copy** of an object?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('9a167ae3-3a6f-42e5-9f40-493df46ff3ca', 'WRITTEN', 'Create a basic class and define a constructor that takes no arguments.', 'Inside the constructor, assign a meaningful default value to one of the class''s instance variables.', 'Provide a simple Java code example that demonstrates a constructor setting an essential attribute to an initial, stable state. Explain how your example illustrates this purpose.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b4483529-0e67-44cb-aaf4-6188838ffc87', 'WRITTEN', 'Think about what could happen if `price` could be changed by any part of the program without any checks.', 'Consider how debugging would be affected if many parts of the code could modify `price` directly.', 'Describe a potential negative consequence of **not applying encapsulation** (i.e., making internal data directly `public`) in a class, using a `Product` class with a `price` attribute as an example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('35a0b16b-7fad-4c90-ba92-8bf155a529fc', 'WRITTEN', 'Think about how they allow different classes to respond to the same method call.', 'Consider the ''contract'' they establish for their implementers or inheritors.', 'Explain how both **interfaces** and **abstract classes** contribute to achieving **polymorphism** in object-oriented programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('833a3045-a4d6-4c02-8f2e-0f6c26dae31a', 'WRITTEN', 'For abstract classes, think about a hierarchy where some common behaviour is shared, but some is not. For interfaces, think about unrelated objects needing a common capability.', 'An abstract class works well when defining a common ''is-a'' base, like `Shape` for `Circle` and `Rectangle`. An interface works for ''behaves-like-a'', like `Nameable` for `Dog` and `Car`.', 'Describe a suitable **use case** for an **abstract class**, and then contrast it with a suitable **use case** for an **interface**, providing an example for each.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c15717c4-7451-4bca-84e4-254ecf57f785', 'WRITTEN', 'Think about the ''implementation'' aspect of abstract classes versus the ''contract'' aspect of interfaces.', 'Consider that abstract classes can carry implementation, which can create dependencies across the hierarchy if changed, whereas interfaces only define signatures.', 'In the context of object-oriented design, explain how **interfaces** promote a design principle related to **loose coupling** more effectively than **abstract classes**.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('01f03e7f-da6e-4fa9-8159-a1fea5aaedf7', 'WRITTEN', 'Consider how encapsulation restricts direct access to an object''s internal data.', 'Think about the role of methods, like getters and setters, in controlling data access and modification.', 'Explain how **encapsulation** contributes to **data protection** and helps prevent **unintended side effects** in Object-Oriented Programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('bfdd8e8f-85c3-488b-81b9-8615e8433fd2', 'MULTIPLE_CHOICE', 'Consider a situation where internal changes to a class do not impact external code.', 'Think about how hiding implementation details protects the system from ripple effects.', 'Which of the following scenarios best illustrates a key benefit of **encapsulation** in object-oriented design?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('744685e6-7137-4b21-863d-11ae6a0a0c9b', 'WRITTEN', 'Think about how hiding internal details affects how much external code needs to ''know'' about a class.', 'Consider how isolating changes within a class impacts system stability and troubleshooting.', 'Discuss how **encapsulation** enhances **modularity** and simplifies **maintenance and debugging** in an Object-Oriented system.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f06dfa92-fc5a-4a8f-8b50-045720cf54ce', 'MULTIPLE_CHOICE', 'Look for one class containing an instance of another class as an attribute.', 'The ''has-a'' relationship is typically achieved through composition, where objects are built from other objects.', 'Which of the following Java code snippets best represents a **''has-a'' relationship**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('f9d89576-54c8-47f1-9d8d-2333734b65f8', 'MULTIPLE_CHOICE', 'Think about the impact on system design principles like flexibility and maintainability.', 'The choice between these relationships affects how easily the system can be changed, extended, or understood.', 'When designing an Object-Oriented system, why is it important to differentiate between ''is-a'' (inheritance) and ''has-a'' (composition) relationships?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('85659db5-9f04-4f40-abfb-88d79ee46520', 'WRITTEN', 'Focus on the concepts of specialisation versus aggregation. How does one class relate to another as a type versus a part?', 'Recall the `Dog` and `Animal` example for ''is-a'', and the `Car` and `Engine` example for ''has-a''.', 'Explain the core difference between an **''is-a'' relationship** and a **''has-a'' relationship** in Object-Oriented Programming. Provide an example for each, ensuring the examples clearly illustrate the distinction.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('cc00c356-dbee-4e3f-9cb0-b44eda2e3e4b', 'MULTIPLE_CHOICE', 'Think about what an exception is in relation to typical program flow.', 'Exceptions are about things that happen unexpectedly during execution.', 'In object-oriented programming, what does an **exception** primarily represent?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('cb717fe1-74c8-4971-b740-d2d652dd1c41', 'MULTIPLE_CHOICE', 'Consider what happens immediately after an exception is thrown.', 'The `catch` block is where the ''handling'' of the exception takes place.', 'Which statement accurately describes the purpose of a **`catch` block**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('68b87841-9f59-414c-942c-446ff38b225b', 'WRITTEN', 'Consider what kind of code goes into each block.', 'An `ArithmeticException` often occurs with specific mathematical operations, like division.', 'Explain how `try` and `catch` blocks work together to manage `ArithmeticException` in Java.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('6410632f-390a-4cc6-8a86-ebdc4aa42ec8', 'MULTIPLE_CHOICE', 'Consider what happens to nested objects or references when a shallow copy is performed.', 'A shallow copy creates a new object but shares references to the original object''s nested components.', 'In object-oriented programming, what accurately describes a **shallow copy** of an object?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('747b45af-0497-4668-95ac-9c135897bc3f', 'WRITTEN', 'Consider what happens if you modify a nested object after performing a shallow copy.', 'Since references are duplicated but not the nested objects themselves, both the original and copied objects will point to the same shared nested objects.', 'Explain the potential **side effects** that can occur when a **shallow copy** is used for an object that contains references to other nested objects.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a2f68fad-3ac8-4993-bc77-0609d22b32c0', 'WRITTEN', 'Think about the goal of preventing changes to one object from affecting another after copying.', 'A deep copy creates completely separate instances of all components, ensuring no shared data.', 'Describe the primary **advantage** of using a **deep copy** over a shallow copy, especially concerning data independence.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('41aeda21-168e-4dd7-97c3-f0491ac8a384', 'WRITTEN', 'Consider what values an object''s attributes might hold if not explicitly set upon creation.', 'Think about the potential consequences of using an object with unpredictable or undefined initial data.', 'Explain why constructors are crucial for ensuring an object is in a **''stable state''** before it is used.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('aa9b7096-b66e-4333-a985-499c564b034f', 'MULTIPLE_CHOICE', 'Think about the lifecycle of an object, specifically its beginning.', 'Consider the keyword typically used to create a new instance of a class.', 'When is a constructor **automatically invoked** in Java?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('697a8302-de94-48d7-acd2-9e6194b8a514', 'WRITTEN', 'Consider a mechanism that defines a contract for what a class *can do* rather than what it *is*.', 'This construct typically contains abstract methods that implementing classes must define, providing a blueprint for behavior.', 'Many modern object-oriented languages, such as Java and .NET, intentionally avoid direct support for multiple inheritance. What specific object-oriented construct do they often use **instead** to achieve a form of **behavioral inheritance**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('02588968-66cb-4567-b248-ee915fc77758', 'MULTIPLE_CHOICE', 'Consider the number of parent classes involved in this type of inheritance.', 'It enables a class to acquire characteristics from more than one source simultaneously.', 'What does **multiple inheritance** allow a class to do in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('86dde6ab-12aa-401c-b92d-83160d21be07', 'WRITTEN', 'Think about popular modern languages commonly used in software development.', 'The Knowledge Component explicitly lists examples that deliberately do not include this feature.', 'Name two specific object-oriented programming languages mentioned that **avoid** multiple inheritance.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('2ef714e8-f94a-4511-a648-9871b1642982', 'WRITTEN', 'Think about the potential advantages and disadvantages of this feature.', 'One aspect relates to what you gain, and the other to the challenges or difficulties it introduces.', 'When evaluating the use of multiple inheritance in an Object-Oriented Programming design, what are the two primary aspects that must be weighed against each other?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0b543673-4122-4f09-9489-4f598e1863ce', 'MULTIPLE_CHOICE', 'Think about how overloaded methods are distinguished from one another.', 'The compiler looks at the number and types of arguments passed during instantiation.', 'When a class has multiple constructors, what is the primary factor the compiler uses to select the appropriate constructor during object instantiation?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('de77a950-8e84-457d-b7b8-0443e6ebefe7', 'MULTIPLE_CHOICE', 'Think about how implementing an interface affects a class''s capabilities and its interaction with other parts of a system.', 'Implementing an interface makes a class compatible with other components that expect a specific set of functionalities.', 'What is the **primary benefit** of a class **implementing an interface**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('4f0299ab-f1d6-4024-a818-6b0f07a1b57a', 'MULTIPLE_CHOICE', 'Consider how objects are created and initialised when different amounts or types of data are available.', 'Constructor overloading adapts the object creation process to the specific data provided at the time of instantiation.', 'What is the main benefit of using **constructor overloading** in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3b648229-1ae9-44b0-b110-795144560724', 'WRITTEN', 'Consider how different constructors can handle varying amounts or types of initial data.', 'Think about scenarios where an object might need to be created with a default state versus a fully customised state.', 'Explain how **constructor overloading** contributes to **flexible object creation** within a class.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('76c987e8-8ced-4eca-a880-d0c4c7c022bd', 'WRITTEN', 'Remember that constructors have distinct signatures. What makes one signature different from another?', 'The compiler matches the arguments provided during object creation to the parameters defined in the constructor''s signature.', 'Consider a Java class called `Product`. Provide a code snippet for this class that defines two overloaded constructors: one that accepts no parameters (a default constructor) and another that accepts a `String` parameter for the product''s `name`. Then, write a line of code demonstrating how to instantiate a `Product` object using the constructor that sets the name. Explain why the compiler chooses this specific constructor.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('72351141-4690-418a-ab49-5fc266bcde68', 'MULTIPLE_CHOICE', 'Consider the methods declared within an interface. What characteristic do they typically have?', 'Interfaces define abstract methods. What is the responsibility of a class that implements an interface regarding these methods?', 'When a concrete class **implements an interface**, what **must** it do to adhere to the interface''s contract?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('cba2963d-4aa1-4c97-9e43-f7122cff4c55', 'WRITTEN', 'Focus on the specific actions a class must perform regarding the interface''s methods.', 'Consider what ''adheres to an interface''s contract'' and ''abstract methods'' mean together.', 'Explain the **contractual obligation** that a concrete class undertakes when it implements an interface.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('9773f4f2-0c18-47d0-8c18-a566e51a2353', 'WRITTEN', 'Define a simple interface with one abstract method. Then, create a concrete class that uses the `implements` keyword.', 'Ensure the implementing class explicitly writes the body for the interface''s method.', 'Provide a Java code snippet demonstrating a class **implementing a simple interface**. In your explanation, specify the interface, the implementing class, and how the class fulfills the interface''s contract.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('a92bd2e9-498b-4bcb-8c47-7a1acbe17a3c', 'MULTIPLE_CHOICE', 'Think about the compiler''s role when a class doesn''t fully satisfy a contract.', 'A class that *must* implement all abstract methods but doesn''t, cannot be considered fully ''concrete'' by the compiler.', 'If a **concrete class** implements an interface but **fails to provide an implementation for one of its abstract methods**, what will be the outcome?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('122ce3a7-5108-4093-a2ce-98b0d92a3064', 'MULTIPLE_CHOICE', 'Consider where the attribute is declared within the code structure.', 'Local scope attributes are tied to the execution of a specific block of code, like a method.', 'In object-oriented programming, what defines an attribute with **local scope**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('fa37af48-c661-4f27-a98b-2418bfe893b3', 'MULTIPLE_CHOICE', 'Think about attributes that define the unique state of an individual object.', 'Each time a new object is created, it gets its own distinct set of these attributes.', 'Which statement accurately describes an attribute with **object scope**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c87a7c57-f62e-488a-89d0-3a2a066d9f4b', 'MULTIPLE_CHOICE', 'Recall the `static` keyword and its purpose.', 'Class-scoped attributes exist independently of any specific object instance.', 'Which statement best describes an attribute with **class scope** in Java?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('328b76e2-e5bf-40f2-b932-55035adbd3ed', 'WRITTEN', 'Consider whether memory is allocated per object or per class, and how this impacts access.', 'One uses the object reference for access, the other uses the class name.', 'Explain the key differences in how **object-scoped** and **class-scoped** attributes are stored in memory and how they are typically accessed in Java.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('dc44054b-3fe5-4c01-adc7-46b10405247d', 'WRITTEN', 'Think about who can access and modify data at different levels.', 'Controlled access to data prevents unwanted changes.', 'How does proper understanding and application of variable scope contribute to ensuring **data integrity** in an object-oriented program?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('7c0e8f4c-e63b-43c5-ad93-357c4ab22a43', 'WRITTEN', 'Focus on where each variable is declared within the class structure.', 'Parameters are local; non-static class fields are object-scoped.', 'Consider the `Cabbie` class snippet below. Identify the **scope** of the `cabbieName` parameter and the `totalTrips` attribute. Justify your answer for each.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b440b7de-c36f-46ce-ba9b-fc9e60558621', 'MULTIPLE_CHOICE', 'Consider how standard operators can be adapted for new data types.', 'Operator overloading allows operators to perform differently based on the data they operate on, making code more intuitive.', 'What is the primary purpose of **operator overloading** in Object-Oriented Programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('69232c5a-00f6-4275-9798-19c5de2de367', 'MULTIPLE_CHOICE', 'Consider an example where the operator''s redefined meaning remains intuitive.', 'Think about common operations with text and how a simple operator might naturally apply.', 'Which of the following is an example of a **judicious** use of operator overloading?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b4a79808-a9d4-46f5-9ba6-3481a5605a93', 'WRITTEN', 'Consider what happens if an operator''s meaning changes in a way that is not commonly expected.', 'Think about how a developer reading the code might interpret an overloaded operator if its behaviour is counter-intuitive.', 'Explain why **operator overloading**, while powerful for creating intuitive syntax, can lead to confusing and hard-to-maintain code if not used judiciously.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('16d2527d-07b4-463d-9fc9-6065d521edab', 'WRITTEN', 'Show how two strings can be combined using the `+` operator.', 'Think about defining two string variables and then joining them with `+`.', 'Provide a simple Java code example demonstrating the use of the `+` operator for **string concatenation**, which is an instance of operator overloading. Explain how this example illustrates the concept.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('19c26b27-0805-4d79-8a3b-e4693d07f074', 'MULTIPLE_CHOICE', 'Recall that a method signature defines how a method is called.', 'The method signature includes the method''s name and its parameter list.', 'Consider the following Java method signature:

```java
public double calculateArea(double length, double width)
```

Which part of this code snippet represents the **method signature**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0f7f5356-ab29-463a-ac1c-d557f77fd1ea', 'MULTIPLE_CHOICE', 'Consider what each part communicates to a user of the method versus what it actually does internally.', 'The signature is about ''what'' a method offers, while the body is about ''how'' it achieves that.', 'What is the primary distinction between a **method signature** (interface) and its **method body** (implementation) in code?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('d054bcd5-05ee-421d-85e5-e73754034061', 'WRITTEN', 'Identify which part tells you ''what'' the method does and how to use it, versus which part tells you ''how'' it does it.', 'The interface is the method''s signature; the implementation is the code inside the curly braces.', 'Explain the concepts of a **method''s interface** and its **implementation** using the following Java code snippet as an example:

```java
public class Calculator {
    public int add(int a, int b) {
        // This is the method body / implementation
        int sum = a + b;
        return sum;
    }
}
```');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('4dcd8570-4b45-4806-93e6-5f5123c57455', 'MULTIPLE_CHOICE', 'Consider what information is visible to other objects wanting to call a method.', 'The signature is the ''how-to-use'' part of a method.', 'In the context of the interface/implementation paradigm, what does a **method signature** primarily represent?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('504c44c2-7371-4b99-be54-a988c211ea39', 'WRITTEN', 'Consider what the ''interface'' of a method provides to its users.', 'If the way a method is called doesn''t change, do its callers need to be modified?', 'A developer updates a method''s internal logic, but its **method signature** remains unchanged. What is the impact of this change on other parts of the codebase that use this method, and why is this significant in software design?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0962e7e2-ca97-48ec-a9c0-8aa87f4cf573', 'WRITTEN', 'Focus on whether the `ReportGenerator` needs to be modified or recompiled.', 'Think about the concept of a ''contract'' provided by the interface.', 'Consider a scenario where a `ReportGenerator` class uses an `IDataSource` interface to fetch data. If the underlying data source implementation changes from a `DatabaseDataSource` to a `WebServiceDataSource`, what is the impact on the `ReportGenerator` class and why is this significant in terms of software design?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('bef352b7-824a-45af-877e-74c4eb0e996d', 'WRITTEN', 'Focus on how code becomes less rigid and adaptable to new implementations.', 'Think about adding new classes without modifying existing code that relies on the interface.', 'Explain how interfaces enhance **flexibility** in Object-Oriented Programming, using the concept of treating objects of different concrete classes as objects of a common interface type. Provide a simple example.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('265e1cb3-2a86-410b-bf9f-a8b7983311b2', 'WRITTEN', 'Consider who has direct control over the attribute''s value.', '`private` attributes force interaction through controlled methods.', 'Discuss how declaring attributes as `private` contributes to **data integrity** and supports the principle of a **minimal interface** in object-oriented programming.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('fe78ea63-8eb3-496b-9931-90430f1a864a', 'MULTIPLE_CHOICE', 'Recall the specific keyword used to declare an interface and the inherent nature of its methods regarding implementation.', 'Interface methods are implicitly public and abstract.', 'Which Java code snippet correctly defines an interface named `Printable` with an abstract method `printDocument()`?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('6d635e86-f2fb-44a6-8e10-cbdd7ef21f5c', 'WRITTEN', 'Consider what happens when you change an underlying service in a system designed with interfaces versus one designed with direct implementations.', 'Think about the ''contract'' that an interface provides and how it insulates clients from changes.', 'Explain how designing a system using **interfaces** rather than directly referencing **concrete implementations** promotes **loose coupling**. Provide an example to illustrate your explanation.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('0d6e8529-998d-40dd-b048-fdb7c8685efa', 'MULTIPLE_CHOICE', 'Consider how interfaces allow different types of objects to be handled in a uniform way.', 'Think about how interfaces enable generic code to interact with various specific implementations.', 'What is the primary purpose of using an **interface** in Object-Oriented Programming (OOP) to achieve polymorphism?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('63165c20-1c2d-478d-83b6-225e7d4964a6', 'MULTIPLE_CHOICE', 'Recall that an interface defines how other parts of the code can interact with a class, without revealing internal details.', 'Think about what parts are declared as public and intended for external use.', 'Consider the following Java class:

```java
public class DataProcessor {
    public void processData(String data) {
        // implementation details here
        System.out.println("Processing: " + data);
    }

    private void logProcessing(String data) {
        // internal logging logic
        System.out.println("Logged: " + data);
    }
}
```

Which of the following represents an **interface** element that another object would typically use to interact with `DataProcessor`?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('9152f72e-7bb5-4ef0-93f1-dbdaca4e5f2e', 'MULTIPLE_CHOICE', 'Look for an example where different objects are processed by generic code that refers to a common interface type.', 'Consider a method that accepts an interface, but can correctly handle any object that implements that interface.', 'Which of the following scenarios best demonstrates **polymorphism** achieved through interfaces?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('868a1f17-d5d3-43fd-85cc-c3de38d12038', 'WRITTEN', 'Think about what an object *is* (data) versus what it *does* (behavior).', 'Attributes describe characteristics, while methods describe actions.', 'In Object-Oriented Programming, differentiate between an **attribute** and a **method** in terms of their primary roles within a class. Provide a brief example of each.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('5207e561-bc10-4a2f-af1f-07c0273ce717', 'MULTIPLE_CHOICE', 'Think about how to make it easy to add new payment gateways in the future without changing existing code.', 'Consider using an abstract contract that all payment gateways must adhere to.', 'A software development team is building an e-commerce platform that needs to integrate with various payment gateways (e.g., PayPal, Stripe, Square). To achieve **loose coupling** and **extensibility**, which design approach is best?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('520bbd96-53fc-4500-981d-651687e36258', 'MULTIPLE_CHOICE', 'Think about how generic code can be written to handle any ''edible'' item.', 'Focus on the idea that the same code can interact with different objects without knowing their specific types.', 'Consider an `interface Edible` with a method `void eat()`. If `Apple` and `Carrot` are concrete classes that both `implement Edible`, how does this demonstrate **reusability**?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('3384c462-7cdf-46b6-b83f-dc571709a61b', 'WRITTEN', 'Polymorphism means ''many forms.'' How do interfaces facilitate these ''many forms'' for a single piece of code?', 'Consider how an interface acts as a common blueprint or contract for different, potentially unrelated, classes.', 'Describe the relationship between interfaces and **polymorphism**. How does an interface make it possible to write **generic code** that operates on various implementing classes interchangeably?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('711196d2-c155-40e7-84a9-eedee40b882a', 'WRITTEN', 'Define an interface, then implement it in two different classes. Show a method that accepts the interface type.', 'The key is that the same method call on the interface reference yields different results depending on the concrete object.', 'Provide a simple Java code example demonstrating how an `Animal` interface with a `makeSound()` method can enable **polymorphism** when processing `Dog` and `Cat` objects. Explain the polymorphic aspect.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('69f519f6-19ee-4c97-883a-f8416d75ad2c', 'MULTIPLE_CHOICE', 'Think about what information an object holds about itself.', 'Attributes represent the characteristics or properties of an object.', 'In Object-Oriented Programming, what is the primary purpose of **attributes** in a class?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('c529bc42-8bc1-462a-b08a-a9eb0d2fe311', 'MULTIPLE_CHOICE', 'Consider the visibility and accessibility of the attribute from outside the class.', 'The `private` modifier limits direct access to the attribute to within its own class.', 'Which of the following best describes the effect of declaring a class attribute as `private`?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('b02e77db-a2d3-441e-89ea-f993d82a0ba7', 'WRITTEN', 'Think about how memory is allocated for `static` members versus instance members.', 'A `static` attribute belongs to the class itself, not to individual objects.', 'Explain the concept of a `static` attribute in an Object-Oriented Programming (OOP) class and how it differs from a non-static (instance) attribute. Provide a simple Java code example illustrating a `static` attribute.');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('afc2df53-9728-4108-a3b6-b164044ef33f', 'MULTIPLE_CHOICE', 'Think about what an interface specifies for classes that implement it.', 'It acts as a set of rules or a blueprint for behaviour that must be followed.', 'What is the primary purpose of defining an **interface** in object-oriented programming?');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('bfe72beb-d220-40a0-854a-d129979a2d89', 'WRITTEN', 'Consider the difference between ''what'' a class can do and ''how'' it does it.', 'Focus on the fact that interfaces declare methods but do not define the code within them.', 'Explain why an interface is described as establishing a "blueprint for behavior without providing implementation details."');
INSERT INTO public.questions (question_id, question_type, hint_level_1, hint_level_2, question_text) VALUES ('46e76d0c-a956-47d0-aa16-08b2e36ea235', 'WRITTEN', 'Think about how an interface provides a common ''face'' for interacting with diverse objects.', 'Consider how different classes can provide their own unique implementation while still adhering to a common method signature.', 'How do interfaces promote **abstraction** and **standardise functionality** across different classes in object-oriented programming?');


--
-- Data for Name: multiple_choice_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('35c97850-9c82-42fa-917f-c8ee852c54c4', 'C', '[{"option_key": "A", "option_text": "It can choose to implement only some of the inherited abstract methods", "option_explanation": "Incorrect. To be concrete, it must implement *all* inherited abstract methods."}, {"option_key": "B", "option_text": "It is not allowed to add new methods or attributes beyond what the abstract class defines", "option_explanation": "Incorrect. A subclass can add its own unique methods and attributes, extending the functionality of its superclass."}, {"option_key": "C", "option_text": "It must provide a concrete implementation for all inherited abstract methods [user query, 128, 130]", "option_explanation": "Correct! This is a fundamental requirement for a subclass to become concrete [user query, 128, 130]."}, {"option_key": "D", "option_text": "It can be instantiated even if it doesn''t implement all abstract methods", "option_explanation": "Incorrect. If it does not implement all abstract methods, it must also be declared abstract and cannot be instantiated directly."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('ffd422dc-dbc7-4a41-a002-91aa03e70dd9', 'B', '[{"option_key": "A", "option_text": "A subclass cannot add new methods beyond the superclass", "option_explanation": "Incorrect. Subclasses can add new methods."}, {"option_key": "B", "option_text": "A subclass can override or extend methods of the superclass", "option_explanation": "Correct! Subclasses inherit methods but can also modify behavior."}, {"option_key": "C", "option_text": "A subclass automatically duplicates all superclass code", "option_explanation": "Incorrect. Inheritance does not duplicate code; it references the superclass."}, {"option_key": "D", "option_text": "A subclass cannot access public members of the superclass", "option_explanation": "Incorrect. Public members are fully accessible."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('642c4a8d-7295-4822-84cd-6c589067b053', 'B', '[{"option_key": "A", "option_text": "`implements`", "option_explanation": "Incorrect. This is used for interfaces, not class inheritance."}, {"option_key": "B", "option_text": "`extends`", "option_explanation": "Correct! The `extends` keyword declares a subclass."}, {"option_key": "C", "option_text": "`inherits`", "option_explanation": "Incorrect. Java does not use this keyword."}, {"option_key": "D", "option_text": "`super`", "option_explanation": "Incorrect. `super` is used inside a subclass to call parent methods or constructors."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('feec1a5d-9095-482d-861a-a698b8b0827c', 'B', '[{"option_key": "A", "option_text": "To duplicate all code from one class into another", "option_explanation": "Incorrect. Inheritance reuses code without duplicating it."}, {"option_key": "B", "option_text": "To allow a subclass to derive properties and behaviors from a superclass", "option_explanation": "Correct! This is the essence of inheritance."}, {"option_key": "C", "option_text": "To execute multiple methods sequentially", "option_explanation": "Incorrect. This describes procedural execution, not inheritance."}, {"option_key": "D", "option_text": "To store data persistently in a database", "option_explanation": "Incorrect. Inheritance is unrelated to database storage."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('73728c43-0dbd-4de1-8e21-65a519874c83', 'C', '[{"option_key": "A", "option_text": "To duplicate code for redundancy purposes", "option_explanation": "Incorrect. Abstraction aims to reduce complexity and allow for code reuse, not duplication [user query, 125]."}, {"option_key": "B", "option_text": "To expose all internal implementation details of an object to other parts of the system", "option_explanation": "Incorrect. Abstraction''s core idea is to hide complex details and show only essential features [user query, 102]."}, {"option_key": "C", "option_text": "To define a common interface for objects while hiding their complex internal implementation details [user query, 102, 128]", "option_explanation": "Correct! This aligns with the definition of abstraction in OOP [user query]."}, {"option_key": "D", "option_text": "To allow multiple classes to share the same memory location for attributes", "option_explanation": "Incorrect. This describes the concept of static members, not abstraction."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('0003e2a5-2711-49ca-95ed-a361b61bc418', 'C', '[{"option_key": "A", "option_text": "`implements`", "option_explanation": "Incorrect. `implements` is used when a class adopts the contract of an interface."}, {"option_key": "B", "option_text": "`virtual`", "option_explanation": "Incorrect. `virtual` is a keyword used in C++ for polymorphic methods, but not in Java for abstract declarations."}, {"option_key": "C", "option_text": "`abstract`", "option_explanation": "Correct! This keyword designates a class or method as abstract."}, {"option_key": "D", "option_text": "`extends`", "option_explanation": "Incorrect. `extends` is used for class inheritance, indicating a class is a subclass of another."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('32c9b366-417a-4b4c-b717-ecdfde1e87d3', 'B', '[{"option_key": "A", "option_text": "The Square class cannot have its own unique attributes or methods", "option_explanation": "Incorrect. Subclasses can have additional attributes and methods."}, {"option_key": "B", "option_text": "The Square class must provide an implementation for any abstract methods defined in Shape", "option_explanation": "Correct! Concrete subclasses must implement all abstract methods of their superclass."}, {"option_key": "C", "option_text": "The Square class will automatically duplicate all code from the Shape class", "option_explanation": "Incorrect. Inheritance allows reuse of code without duplication."}, {"option_key": "D", "option_text": "The Shape class can directly instantiate Square objects", "option_explanation": "Incorrect. Abstract classes cannot be directly instantiated."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('07a34361-54aa-456e-8e3e-f33ab7e54baf', 'B', '[{"option_key": "A", "option_text": "One object containing another object", "option_explanation": "Incorrect. This describes a ''has-a'' relationship, where one class contains another as an attribute."}, {"option_key": "B", "option_text": "A class inheriting attributes and methods from a superclass", "option_explanation": "Correct! This shows a subclass is a specialized version of its superclass, which is the ''is-a'' relationship."}, {"option_key": "C", "option_text": "Two unrelated classes sharing a common interface", "option_explanation": "Incorrect. Sharing an interface allows common behavior but doesn''t make one class a type of the other."}, {"option_key": "D", "option_text": "A method calling another method within the same class", "option_explanation": "Incorrect. This is just an internal operation, not a relationship between classes."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('02785fc6-3f61-4ffd-8b2b-0c55d72a20e0', 'C', '[{"option_key": "A", "option_text": "A Car class having an Engine object as an attribute", "option_explanation": "Incorrect. This shows composition, not ''is-a''."}, {"option_key": "B", "option_text": "A Payroll object sending a message to an Employee object", "option_explanation": "Incorrect. This is interaction between objects, not inheritance."}, {"option_key": "C", "option_text": "A Dog class declared as `class Dog extends Mammal`", "option_explanation": "Correct! Dog is a specialized type of Mammal, demonstrating the ''is-a'' relationship."}, {"option_key": "D", "option_text": "A Math object with myInt1 and myInt2 attributes", "option_explanation": "Incorrect. This only shows attributes of a single class, not inheritance."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('fe1cf1ab-2d94-4ff9-b4b4-451a50dc2024', 'B', '[{"option_key": "A", "option_text": "The subclass must declare the method as `private` to hide its implementation.", "option_explanation": "Incorrect. While implementation details are often private, the abstract method must be made concrete and accessible for its intended use, often publicly or protectedly."}, {"option_key": "B", "option_text": "The subclass must provide its own **concrete implementation** for that method.", "option_explanation": "Correct! A subclass inheriting an abstract method must provide a concrete implementation for it, otherwise, the subclass itself becomes abstract."}, {"option_key": "C", "option_text": "The subclass can choose to ignore the method if it''s not relevant to its specific functionality.", "option_explanation": "Incorrect. Failing to implement an abstract method in a concrete subclass will result in a compilation error, or the subclass itself becoming abstract."}, {"option_key": "D", "option_text": "The subclass automatically inherits a default implementation from the abstract superclass.", "option_explanation": "Incorrect. Abstract methods by definition have no implementation in the abstract class, requiring concrete subclasses to provide it."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('dcb1de41-8588-483d-9e02-77715c9a95c5', 'D', '[{"option_key": "A", "option_text": "```java\nclass Circle extends Shape {\n    // No draw() method here\n}\n```", "option_explanation": "Incorrect. A concrete subclass must provide an implementation for all inherited abstract methods."}, {"option_key": "B", "option_text": "```java\nclass Circle {\n    public void draw() {\n        System.out.println(\"Drawing a circle.\");\n    }\n}\n```", "option_explanation": "Incorrect. This class does not extend `Shape`, so it does not fulfil the contract."}, {"option_key": "C", "option_text": "```java\nclass Circle extends Shape {\n    public abstract void draw(); // Still abstract\n}\n```", "option_explanation": "Incorrect. This `Circle` class remains abstract because `draw()` is still abstract, meaning it doesn''t provide a concrete implementation."}, {"option_key": "D", "option_text": "```java\nclass Circle extends Shape {\n    public void draw() {\n        System.out.println(\"Drawing a circle.\");\n    }\n}\n```", "option_explanation": "Correct! This `Circle` class correctly extends `Shape` and provides a concrete implementation for the `draw()` method, fulfilling the abstract contract."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('79f145b2-3430-443d-a11b-ed2522d1a3df', 'B', '[{"option_key": "A", "option_text": "Only the abstract class is responsible for defining the behavior of its abstract methods.", "option_explanation": "Incorrect. The abstract class only declares the abstract method; the concrete subclasses are responsible for providing its behaviour."}, {"option_key": "B", "option_text": "Implementing an abstract method means providing a unique, specific behaviour for that method within the subclass.", "option_explanation": "Correct! This is the essence of implementing abstract contracts, allowing for polymorphic behaviour where each subclass defines its own specific way of performing the abstract operation."}, {"option_key": "C", "option_text": "Abstract methods must be implemented with identical code in all concrete subclasses.", "option_explanation": "Incorrect. While they must be implemented, the strength of polymorphism is that each subclass can implement the method differently, reflecting its specific nature (e.g., `Circle` draws differently from `Rectangle`)."}, {"option_key": "D", "option_text": "The implementation of an abstract method can be skipped if the subclass is small and simple.", "option_explanation": "Incorrect. Failing to implement all abstract methods makes the subclass itself an abstract class, preventing its direct instantiation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('3c68f975-fa03-45a7-ba24-d832077c6b3f', 'C', '[{"option_key": "A", "option_text": "To make the system more complex and challenging to use.", "option_explanation": "Incorrect. Hiding details aims to simplify, not complicate, the user experience."}, {"option_key": "B", "option_text": "To prevent users from customising the interface.", "option_explanation": "Incorrect. Hiding implementation details is about maintainability and flexibility for developers, not preventing user customisation."}, {"option_key": "C", "option_text": "**To allow underlying changes or improvements without affecting the user''s interaction.**", "option_explanation": "Correct! Hiding implementation details ensures that modifications to how a function is performed internally do not require changes to how users interact with the interface, promoting flexibility."}, {"option_key": "D", "option_text": "To expose all internal data for direct manipulation.", "option_explanation": "Incorrect. This contradicts the principle of data hiding and controlled access, which are fundamental to good design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('ad557157-7408-48c4-9818-2671d40934eb', 'C', '[{"option_key": "A", "option_text": "The specific data types and algorithms used internally.", "option_explanation": "Incorrect. Abstraction aims to hide specific internal details."}, {"option_key": "B", "option_text": "The detailed graphical elements and visual styles.", "option_explanation": "Incorrect. While important, these are often implementation details of a graphical user interface (GUI), not the core focus of abstraction itself."}, {"option_key": "C", "option_text": "**The essential features and common functionalities of the system.**", "option_explanation": "Correct! Abstraction focuses on identifying and presenting only the necessary aspects and common behaviours to the user, hiding complex internal details."}, {"option_key": "D", "option_text": "The performance metrics and execution speed of the underlying code.", "option_explanation": "Incorrect. Performance is a concern for implementation, not the primary focus of abstract interface design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('1ebdbf0d-2817-4628-8784-7a081f246251', 'C', '[{"option_key": "A", "option_text": "To store private data attributes within the class.", "option_explanation": "Incorrect. Data attributes are generally part of the implementation, not the interface, and are often kept private."}, {"option_key": "B", "option_text": "To implement complex internal algorithms.", "option_explanation": "Incorrect. Algorithms are part of the implementation, which should be hidden."}, {"option_key": "C", "option_text": "**To specify the public methods and behaviours that other objects can use.**", "option_explanation": "Correct! An interface defines the public signature of a class, detailing how other objects can interact with it and use its services."}, {"option_key": "D", "option_text": "To combine data and behaviour into a single, hidden unit.", "option_explanation": "Incorrect. This describes encapsulation, but the interface specifically refers to the *exposed* part, not the hidden unit itself."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('05ca5bdb-7bc7-4b08-9ef8-e97179de990e', 'C', '[{"option_key": "A", "option_text": "The specific data types and algorithms used internally.", "option_explanation": "Incorrect. Abstraction aims to hide specific internal details."}, {"option_key": "B", "option_text": "The detailed graphical elements and visual styles.", "option_explanation": "Incorrect. While important, these are often implementation details of a graphical user interface (GUI), not the core focus of abstraction itself."}, {"option_key": "C", "option_text": "**The essential features and common functionalities of the system.**", "option_explanation": "Correct! Abstraction focuses on identifying and presenting only the necessary aspects and common behaviours to the user, hiding complex internal details."}, {"option_key": "D", "option_text": "The performance metrics and execution speed of the underlying code.", "option_explanation": "Incorrect. Performance is a concern for implementation, not the primary focus of abstract interface design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('d9a55a8d-727b-4159-b707-eedf74787ef0', 'C', '[{"option_key": "A", "option_text": "To make the system more complex and challenging to use.", "option_explanation": "Incorrect. Hiding details aims to simplify, not complicate, the user experience."}, {"option_key": "B", "option_text": "To prevent users from customising the interface.", "option_explanation": "Incorrect. Hiding implementation details is about maintainability and flexibility for developers, not preventing user customisation."}, {"option_key": "C", "option_text": "**To allow underlying changes or improvements without affecting the user''s interaction.**", "option_explanation": "Correct! Hiding implementation details ensures that modifications to how a function is performed internally do not require changes to how users interact with the interface, promoting flexibility."}, {"option_key": "D", "option_text": "To expose all internal data for direct manipulation.", "option_explanation": "Incorrect. This contradicts the principle of data hiding and controlled access, which are fundamental to good design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c1c917f6-47e9-43d6-9644-543511643a7e', 'C', '[{"option_key": "A", "option_text": "To store private data attributes within the class.", "option_explanation": "Incorrect. Data attributes are generally part of the implementation, not the interface, and are often kept private."}, {"option_key": "B", "option_text": "To implement complex internal algorithms.", "option_explanation": "Incorrect. Algorithms are part of the implementation, which should be hidden."}, {"option_key": "C", "option_text": "**To specify the public methods and behaviours that other objects can use.**", "option_explanation": "Correct! An interface defines the public signature of a class, detailing how other objects can interact with it and use its services."}, {"option_key": "D", "option_text": "To combine data and behaviour into a single, hidden unit.", "option_explanation": "Incorrect. This describes encapsulation, but the interface specifically refers to the *exposed* part, not the hidden unit itself."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('8b39feab-7d75-4c8d-b1cd-177a6f23ecdf', 'C', '[{"option_key": "A", "option_text": "The specific data types and algorithms used internally.", "option_explanation": "Incorrect. Abstraction aims to hide specific internal details."}, {"option_key": "B", "option_text": "The detailed graphical elements and visual styles.", "option_explanation": "Incorrect. While important, these are often implementation details of a graphical user interface (GUI), not the core focus of abstraction itself."}, {"option_key": "C", "option_text": "**The essential features and common functionalities of the system.**", "option_explanation": "Correct! Abstraction focuses on identifying and presenting only the necessary aspects and common behaviours to the user, hiding complex internal details."}, {"option_key": "D", "option_text": "The performance metrics and execution speed of the underlying code.", "option_explanation": "Incorrect. Performance is a concern for implementation, not the primary focus of abstract interface design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('e57fa057-585c-4abb-95ec-320343fb6cf5', 'C', '[{"option_key": "A", "option_text": "To make the system more complex and challenging to use.", "option_explanation": "Incorrect. Hiding details aims to simplify, not complicate, the user experience."}, {"option_key": "B", "option_text": "To prevent users from customising the interface.", "option_explanation": "Incorrect. Hiding implementation details is about maintainability and flexibility for developers, not preventing user customisation."}, {"option_key": "C", "option_text": "**To allow underlying changes or improvements without affecting the user''s interaction.**", "option_explanation": "Correct! Hiding implementation details ensures that modifications to how a function is performed internally do not require changes to how users interact with the interface, promoting flexibility."}, {"option_key": "D", "option_text": "To expose all internal data for direct manipulation.", "option_explanation": "Incorrect. This contradicts the principle of data hiding and controlled access, which are fundamental to good design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('05451828-5f5f-4066-b83b-f22af4a617f7', 'C', '[{"option_key": "A", "option_text": "To store private data attributes within the class.", "option_explanation": "Incorrect. Data attributes are generally part of the implementation, not the interface, and are often kept private."}, {"option_key": "B", "option_text": "To implement complex internal algorithms.", "option_explanation": "Incorrect. Algorithms are part of the implementation, which should be hidden."}, {"option_key": "C", "option_text": "**To specify the public methods and behaviours that other objects can use.**", "option_explanation": "Correct! An interface defines the public signature of a class, detailing how other objects can interact with it and use its services."}, {"option_key": "D", "option_text": "To combine data and behaviour into a single, hidden unit.", "option_explanation": "Incorrect. This describes encapsulation, but the interface specifically refers to the *exposed* part, not the hidden unit itself."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('ff5a4a81-fdab-479b-9424-e3e9b5801553', 'B', '[{"option_key": "A", "option_text": "An interface that directly specifies every detailed step of an operation.", "option_explanation": "Incorrect. This describes a concrete interface, which limits reusability by being too specific."}, {"option_key": "B", "option_text": "An interface that defines general user goals without dictating specific implementation steps.", "option_explanation": "Correct! Abstract interfaces focus on high-level goals, making them adaptable and highly reusable across diverse contexts."}, {"option_key": "C", "option_text": "An interface that is only used within a single, specific class and cannot be shared.", "option_explanation": "Incorrect. Reusability is a key goal, which means interfaces should ideally be shareable across multiple classes."}, {"option_key": "D", "option_text": "An interface that requires all classes to use the exact same internal implementation.", "option_explanation": "Incorrect. Abstract interfaces allow for diverse implementations while maintaining a consistent public definition."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('34d82057-a293-4f9a-86ef-df067ca2909e', 'B', '[{"option_key": "A", "option_text": "It forces all dependent classes to be rewritten with every implementation change.", "option_explanation": "Incorrect. This is what you want to avoid; a consistent interface prevents widespread rewrites."}, {"option_key": "B", "option_text": "It simplifies system maintenance and promotes stability by not affecting external interactions.", "option_explanation": "Correct! Consistency ensures that other parts of the system can continue to use the interface without disruption, regardless of internal modifications."}, {"option_key": "C", "option_text": "It makes the interface more concrete and less abstract, improving performance.", "option_explanation": "Incorrect. Interface consistency is about stability and ease of use, not about making it less abstract or directly improving performance."}, {"option_key": "D", "option_text": "It is a requirement only for procedural programming, not Object-Oriented Programming.", "option_explanation": "Incorrect. Interface consistency is a fundamental principle for good design in Object-Oriented Programming for reusability and maintainability."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('cde20b6e-eea6-4e55-b944-1df6fadb2528', 'B', '[{"option_key": "A", "option_text": "```java\nclass ReportGenerator {\n    void generatePDF() { /* complex PDF generation logic */ }\n}\n```", "option_explanation": "Incorrect. This is a concrete class with a specific implementation, not an abstract interface."}, {"option_key": "B", "option_text": "```java\ninterface Printable {\n    void printDocument();\n}\n```", "option_explanation": "Correct! This interface defines a general action (`printDocument`) without specifying how it''s done, allowing diverse implementations and promoting reusability."}, {"option_key": "C", "option_text": "```java\npublic class DataProcessor {\n    public int processData(String input) { return input.length(); }\n}\n```", "option_explanation": "Incorrect. This is a concrete class with a fully defined method, which is not an abstract interface for reusability."}, {"option_key": "D", "option_text": "```java\nabstract class Vehicle {\n    void startEngine() { System.out.println(\"Engine started.\"); }\n}\n```", "option_explanation": "Incorrect. While an abstract class, `startEngine()` is a concrete method. An abstract interface would have an abstract method to be implemented by subclasses."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('7805bbf6-6a55-4dd9-abc3-32182da43799', 'C', '[{"option_key": "A", "option_text": "The data an object stores, such as its attributes.", "option_explanation": "Incorrect. This describes object data or attributes."}, {"option_key": "B", "option_text": "The internal structure of the class blueprint.", "option_explanation": "Incorrect. This relates to class anatomy, not directly to what an object can do."}, {"option_key": "C", "option_text": "The observable **actions or operations** an object can perform.", "option_explanation": "Correct! Object behaviors define what an object can do, which is implemented through its methods."}, {"option_key": "D", "option_text": "The communication messages between different classes.", "option_explanation": "Incorrect. Messages are the communication mechanism used for invoking behaviors, not the behaviors themselves."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('edbab82e-1826-4efb-b07f-f7d684d9bc50', 'C', '[{"option_key": "A", "option_text": "To ensure the object''s internal data remains hidden from external access.", "option_explanation": "Incorrect. While data hiding is important, it''s not the primary reason for focusing on user perspective to define behaviors."}, {"option_key": "B", "option_text": "To streamline the debugging process by limiting the number of methods.", "option_explanation": "Incorrect. Although good design aids debugging, this is not the main purpose of considering user perspective when defining behaviors."}, {"option_key": "C", "option_text": "To ensure the object provides **only the services and functionalities that its users actually need**, making it useful and concise.", "option_explanation": "Correct! Designing from the user''s perspective ensures the class provides relevant and necessary services, focusing on utility and conciseness."}, {"option_key": "D", "option_text": "To automatically generate all possible methods the object might ever need.", "option_explanation": "Incorrect. The goal is often a minimal public interface, not generating every possible method."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('eb79b12f-a85f-475f-816e-bdde79fe19f4', 'B', '[{"option_key": "A", "option_text": "A rule dictating the naming convention for an object''s methods.", "option_explanation": "Incorrect. This is a design guideline or standard, not an environmental constraint."}, {"option_key": "B", "option_text": "A limitation imposed by the **external environment** (e.g., hardware, network) that affects an object''s functionality.", "option_explanation": "Correct! Environmental constraints are external limitations that affect what an object can do."}, {"option_key": "C", "option_text": "The maximum number of attributes an object can have.", "option_explanation": "Incorrect. This is an internal design choice or language limitation, not an external environmental constraint."}, {"option_key": "D", "option_text": "The security protocol required for object-to-object communication.", "option_explanation": "Incorrect. While important, this is a specific type of design requirement for communication, not a general environmental constraint on functionality."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('e1ed95f4-7a5c-4fb1-9195-73ee1a7fd8a5', 'B', '[{"option_key": "A", "option_text": "Only the human end-customer who directly interacts with the software’s graphical interface.", "option_explanation": "Incorrect. While human end-customers are users, the term also encompasses other entities."}, {"option_key": "B", "option_text": "Any entity, including other objects or internal roles, that sends messages to or receives services from the class.", "option_explanation": "Correct. A user in interface design refers to any interacting party, whether human, another object, or a specific internal role."}, {"option_key": "C", "option_text": "Exclusively the software developers responsible for writing the class’s code.", "option_explanation": "Incorrect. Developers create the class, but they are not the only ''users'' in the context of interface design."}, {"option_key": "D", "option_text": "Only the attributes and data internal to the class itself.", "option_explanation": "Incorrect. Attributes represent the state of the object, not the parties interacting with it."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c027d03c-5c65-47f6-9a13-a418e6b792b6', 'C', '[{"option_key": "A", "option_text": "The private attributes and internal data structures used by the class.", "option_explanation": "Incorrect. These are part of the internal implementation, not the public interface."}, {"option_key": "B", "option_text": "The internal logic and algorithms that a method uses to achieve its tasks.", "option_explanation": "Incorrect. This describes the internal implementation of methods, which is hidden from the public interface."}, {"option_key": "C", "option_text": "The set of public methods and services that are made available for interaction with other objects.", "option_explanation": "Correct! The public interface defines the external contract of a class, specifying the services it offers."}, {"option_key": "D", "option_text": "The version control and deployment strategy for the class''s code.", "option_explanation": "Incorrect. This relates to software development processes, not the definition of a class''s interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('d1c3ed01-5297-4f3e-8a60-5400867c65cd', 'C', '[{"option_key": "A", "option_text": "Only the credit card company that processes the payment.", "option_explanation": "Incorrect. The credit card company is an external service provider, not a direct user of the class interface for design purposes."}, {"option_key": "B", "option_text": "The database storing payment records, but not the customer initiating the payment.", "option_explanation": "Incorrect. Both the database (for storing results) and the customer (initiating) are relevant users for interface design."}, {"option_key": "C", "option_text": "A `ShoppingCart` object that invokes a method to finalise an order, and the customer entering card details.", "option_explanation": "Correct. Both the `ShoppingCart` object and the customer are interacting parties with distinct requirements for the `PaymentProcessor` interface."}, {"option_key": "D", "option_text": "The internal code logic that validates payment data before processing.", "option_explanation": "Incorrect. Internal code logic for validation is part of the class''s implementation, not a separate ''user'' of its public interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('46ab0646-3b78-490d-81c5-9435a5861a90', 'B', '[{"option_key": "A", "option_text": "It simplifies the development process by limiting the number of public methods.", "option_explanation": "Incorrect. Identifying all users can increase interface complexity by revealing more diverse requirements, though it leads to a more comprehensive design."}, {"option_key": "B", "option_text": "It ensures the interface is realistic and usable, satisfying the varied requirements and constraints of all interacting parties.", "option_explanation": "Correct. Understanding all users is paramount for creating an interface that works effectively for everyone and everything involved."}, {"option_key": "C", "option_text": "It makes it easier to change the class’s internal implementation without affecting any users.", "option_explanation": "Incorrect. While good design aims for this, identifying users primarily focuses on external interaction needs, not internal implementation changes, which are related to information hiding."}, {"option_key": "D", "option_text": "It helps determine the specific programming language the class should be written in.", "option_explanation": "Incorrect. User identification is a conceptual design step, independent of specific programming language choices."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('9f2604be-124c-451d-8d5b-983f80a98751', 'B', '[{"option_key": "A", "option_text": "The documented public methods that interact with external systems.", "option_explanation": "Incorrect. This describes the public interface, which is distinct from implementation."}, {"option_key": "B", "option_text": "The internal details, private attributes, and hidden logic that enable the class to perform its functions.", "option_explanation": "Correct! The implementation encompasses all the internal mechanisms of a class."}, {"option_key": "C", "option_text": "The way a class is named and organized within a project''s file structure.", "option_explanation": "Incorrect. This refers to naming conventions and project organization, not the class''s internal workings."}, {"option_key": "D", "option_text": "The process of creating new instances of the class using a constructor.", "option_explanation": "Incorrect. While constructors are part of a class, this option describes instantiation, not the overall implementation concept."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c4715bd3-517b-425d-9bcf-f167262d5277', 'B', '[{"option_key": "A", "option_text": "The class name section.", "option_explanation": "Incorrect. The class name section identifies the class, not its data."}, {"option_key": "B", "option_text": "The attributes section.", "option_explanation": "Correct! The attributes section defines the data fields or properties that store an object''s state."}, {"option_key": "C", "option_text": "The methods section.", "option_explanation": "Incorrect. The methods section defines behaviours, not data."}, {"option_key": "D", "option_text": "The relationships section.", "option_explanation": "Incorrect. Relationships describe how classes interact with each other, not their internal data."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('b1adc3b9-38a9-4028-aad6-251108592819', 'D', '[{"option_key": "A", "option_text": "`private`", "option_explanation": "`private` methods are internal to the class and cannot be directly invoked by other objects."}, {"option_key": "B", "option_text": "`protected`", "option_explanation": "`protected` allows access by subclasses and within the same package, but not necessarily all other objects."}, {"option_key": "C", "option_text": "`static`", "option_explanation": "`static` methods belong to the class itself rather than an instance, but don''t define general accessibility for object invocation from outside."}, {"option_key": "D", "option_text": "`public`", "option_explanation": "Correct. The `public` keyword designates a method as part of the class''s public interface, allowing external access."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('a117a00a-194f-493c-90dd-036707b26568', 'B', '[{"option_key": "A", "option_text": "It automatically makes all class attributes accessible to all other objects by default.", "option_explanation": "Incorrect. This separation typically involves keeping attributes private to maintain control."}, {"option_key": "B", "option_text": "It allows modifications to the internal logic and data structures without requiring changes to external code that uses the class.", "option_explanation": "Correct! This enhances maintainability and modularity, as external users only rely on the stable interface."}, {"option_key": "C", "option_text": "It eliminates the need for any form of error handling within the class methods.", "option_explanation": "Incorrect. Error handling remains a crucial part of robust implementation."}, {"option_key": "D", "option_text": "It requires all classes in a system to inherit directly from a single parent class.", "option_explanation": "Incorrect. This describes single inheritance, not the primary benefit of interface-implementation separation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('3633fbab-bcd9-4950-8d15-a33fc79d27f3', 'C', '[{"option_key": "A", "option_text": "Attributes", "option_explanation": "Attributes store data or properties that represent an object''s state, not its behaviors."}, {"option_key": "B", "option_text": "Constructors", "option_explanation": "Constructors are special methods used to initialize an object when it''s created, not to define its general behaviors."}, {"option_key": "C", "option_text": "Methods", "option_explanation": "Correct. Methods encapsulate the actions and operations an object can perform, making them the representation of an object''s behaviors."}, {"option_key": "D", "option_text": "Class Name", "option_explanation": "The class name identifies the blueprint for objects, not their specific behaviors."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('f3e2cd90-912c-44c3-998a-e6b3bf38511d', 'C', '[{"option_key": "A", "option_text": "`//` and ends at the line break.", "option_explanation": "This syntax is for single-line comments, not multi-line."}, {"option_key": "B", "option_text": "`#` and ends at the line break.", "option_explanation": "This syntax is commonly used in scripting languages, not Java for comments."}, {"option_key": "C", "option_text": "`/*` and correctly terminated by `*/`.", "option_explanation": "Correct. `/*` opens a multi-line comment, and `*/` closes it, allowing the comment to span multiple lines."}, {"option_key": "D", "option_text": "`<!--` and correctly terminated by `-->`.", "option_explanation": "This syntax is typically used for comments in HTML or XML, not Java code."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('ca327a31-5a12-45be-9974-814191640a2b', 'C', '[{"option_key": "A", "option_text": "The middle section, below the class name.", "option_explanation": "Incorrect. This section is typically for attributes."}, {"option_key": "B", "option_text": "The bottom section, below the attributes.", "option_explanation": "Incorrect. This section is typically for methods."}, {"option_key": "C", "option_text": "The top section of the class box.", "option_explanation": "Correct! The top section of a UML class diagram always holds the class''s name."}, {"option_key": "D", "option_text": "Outside the class box, as a separate label.", "option_explanation": "Incorrect. The class name is an integral part of the class''s representation within its box."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('8946a048-2cb1-45a2-8cc6-14dd000710d1', 'B', '[{"option_key": "A", "option_text": "Comprehensive and include all internal helper methods.", "option_explanation": "Including internal helper methods violates the principle of hiding internal details and minimalism."}, {"option_key": "B", "option_text": "Abstract and minimal, exposing only essential functionality.", "option_explanation": "Correct. This design provides necessary functionality while keeping internal workings hidden for conciseness and proper design."}, {"option_key": "C", "option_text": "Concrete and extensive, providing detailed access to all class components.", "option_explanation": "Concrete and extensive interfaces can lead to unnecessary complexity and expose internal details."}, {"option_key": "D", "option_text": "Static and unchangeable to ensure consistent behaviour.", "option_explanation": "While consistency is important, the primary design principles for public interfaces are abstraction and minimalism, not necessarily static or unchangeable qualities."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('eafc849b-8947-42f2-a389-1af9984448c2', 'C', '[{"option_key": "A", "option_text": "The class name section.", "option_explanation": "Incorrect. The class name section identifies the class."}, {"option_key": "B", "option_text": "The attributes section.", "option_explanation": "Incorrect. The attributes section stores data, not actions."}, {"option_key": "C", "option_text": "The methods section.", "option_explanation": "Correct! The methods section lists the operations or behaviors that instances of the class can perform."}, {"option_key": "D", "option_text": "The stereotypes section.", "option_explanation": "Incorrect. Stereotypes are used for extending the UML, not for defining operations."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('80e0e991-1c4f-4e10-8998-2c913bda0173', 'B', '[{"option_key": "A", "option_text": "To store data or properties of an object.", "option_explanation": "This describes attributes, which store data, not methods."}, {"option_key": "B", "option_text": "To define the behaviors or actions an object can perform.", "option_explanation": "Correct. Methods encapsulate the actions and operations an object can perform, representing its behaviors."}, {"option_key": "C", "option_text": "To establish relationships between different classes.", "option_explanation": "Class relationships are typically established through concepts like inheritance or composition, not individual methods."}, {"option_key": "D", "option_text": "To manage the memory allocation for an object.", "option_explanation": "Memory allocation is typically handled by constructors and the system''s runtime, not the primary purpose of an arbitrary method."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('88d37ef1-2aa8-462c-91d7-58e1dbb977b9', 'D', '[{"option_key": "A", "option_text": "To increase the execution speed of the program.", "option_explanation": "Comments are ignored by the compiler and do not affect program execution speed."}, {"option_key": "B", "option_text": "To define the data types of variables and methods.", "option_explanation": "Data types are defined by programming language syntax, not by comments."}, {"option_key": "C", "option_text": "To hide specific parts of the code from other developers.", "option_explanation": "Comments clarify code, they do not hide it. Code hiding is achieved through access modifiers."}, {"option_key": "D", "option_text": "To clarify the class''s function, internal logic, and facilitate maintenance.", "option_explanation": "Correct. Comments are crucial for understanding the purpose and behavior of a class and its components, making maintenance easier."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('a22216a5-7c02-4dbd-b627-99057f2b9299', 'C', '[{"option_key": "A", "option_text": "To manage memory allocation for private attributes.", "option_explanation": "Memory allocation is typically handled by the system or constructors, not the primary role of public interface methods."}, {"option_key": "B", "option_text": "To control internal logic and data processing without external interaction.", "option_explanation": "Public methods are designed for external interaction, not to restrict it completely."}, {"option_key": "C", "option_text": "To define the services a class offers as its external API.", "option_explanation": "Correct. Public interface methods are the external points of interaction that expose the class''s services."}, {"option_key": "D", "option_text": "To document the historical development of the class.", "option_explanation": "While comments help with documentation, defining services is the core purpose of the methods themselves."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('2eaab065-6616-46f2-9933-bc07bbf03945', 'C', '[{"option_key": "A", "option_text": "A new class structure is defined.", "option_explanation": "Defining a class structure is done before instantiation, not as a result of it."}, {"option_key": "B", "option_text": "The class''s blueprint is modified.", "option_explanation": "Instantiation uses the blueprint; it does not modify it."}, {"option_key": "C", "option_text": "A concrete object is created in memory.", "option_explanation": "Correct. Instantiation creates a live, usable object from the class blueprint."}, {"option_key": "D", "option_text": "A new programming language is generated.", "option_explanation": "Instantiation is an OOP concept, not a language generation process."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('1e9e28c9-9590-44bc-8971-2a29dbd2e4aa', 'D', '[{"option_key": "A", "option_text": "An object defines a class''s behavior, while a class holds an object''s data.", "option_explanation": "A class defines both behavior and data, and an object is an instance of that definition."}, {"option_key": "B", "option_text": "A class is an instance of an object, created at runtime.", "option_explanation": "Incorrect; an object is an instance of a class, not the other way around."}, {"option_key": "C", "option_text": "An object is a blueprint for a class, providing its structure.", "option_explanation": "Incorrect; a class is the blueprint for an object."}, {"option_key": "D", "option_text": "A class is a blueprint, and an object is a concrete entity created from that blueprint.", "option_explanation": "Correct. The class provides the structure and behavior definition, and the object is a real instance of it in memory."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('6157ccc8-f53d-4edf-9fab-db0e9c92c73f', 'B', '[{"option_key": "A", "option_text": "To define the attributes and methods of a new class.", "option_explanation": "Defining attributes and methods occurs during class definition, not as a result of message sending."}, {"option_key": "B", "option_text": "To allow objects to communicate and invoke operations on one another.", "option_explanation": "Correct. Message sending is the mechanism for objects to interact and trigger specific actions in other objects."}, {"option_key": "C", "option_text": "To restrict direct access to an object''s internal data.", "option_explanation": "Restricting access to internal data is a concept related to encapsulation and data hiding, not message sending directly."}, {"option_key": "D", "option_text": "To establish an ''is-a'' relationship between a subclass and a superclass.", "option_explanation": "The ''is-a'' relationship is fundamental to inheritance, not message sending."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('5dbc1405-c207-4ffe-ad5c-71633ad29aa9', 'A', '[{"option_key": "A", "option_text": "`myCalculator`", "option_explanation": "Correct. `myCalculator` is the specific object that is receiving the `add` message."}, {"option_key": "B", "option_text": "`add`", "option_explanation": "`add` is the method being invoked, which is part of the message content."}, {"option_key": "C", "option_text": "`5, 10`", "option_explanation": "`5, 10` are the arguments passed to the method, which are also part of the message content."}, {"option_key": "D", "option_text": "`;`", "option_explanation": "The semicolon is a statement terminator in Java syntax."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('37391e56-d241-41a5-a7dc-0337efd3b083', 'C', '[{"option_key": "A", "option_text": "To directly modify a private instance variable.", "option_explanation": "Direct modification of private variables is not allowed. Setters provide a controlled way to modify them."}, {"option_key": "B", "option_text": "To define the overall behavior of an object.", "option_explanation": "While methods define behavior, a getter has a specific purpose of retrieving an attribute''s value, not defining all behavior."}, {"option_key": "C", "option_text": "To retrieve the value of a private instance variable in a controlled manner.", "option_explanation": "Correct. Getters provide public, controlled access to read the value of private instance variables."}, {"option_key": "D", "option_text": "To create a new instance of an object.", "option_explanation": "Creating a new instance of an object is typically done using constructors."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('8d3c8c63-7c2a-4ae2-b052-a14f01bdcfd1', 'B', '[{"option_key": "A", "option_text": "It allows direct manipulation of the instance variable by any external object.", "option_explanation": "Setters provide controlled access, not direct manipulation, to prevent unintended changes."}, {"option_key": "B", "option_text": "It ensures data integrity by preventing invalid values from being assigned to the instance variable.", "option_explanation": "Correct. Validation within a setter protects the object''s state by rejecting data that does not meet specified criteria."}, {"option_key": "C", "option_text": "It makes the instance variable public for easier access.", "option_explanation": "The instance variable remains private; setters provide an indirect, controlled access point."}, {"option_key": "D", "option_text": "It automatically transforms the data into a different type without explicit code.", "option_explanation": "While transformation is possible, the primary benefit highlighted for setters with validation is data integrity, not automatic type conversion."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('fde1c387-3597-4a5c-8673-871ebb4ad75b', 'B', '[{"option_key": "A", "option_text": "Private variables can be accessed directly by any other object, improving performance.", "option_explanation": "Private variables are explicitly designed to restrict direct access from outside the class, not to improve performance through direct access."}, {"option_key": "B", "option_text": "It is a core aspect of encapsulation, ensuring that internal data is protected and accessed only through defined methods.", "option_explanation": "Correct. Making variables private and exposing them via public methods is the essence of encapsulation, promoting data protection and controlled interaction."}, {"option_key": "C", "option_text": "Private variables are automatically initialized to safe default values by the compiler.", "option_explanation": "While some languages provide default initialization, this is not the primary reason for declaring variables private in the context of getters/setters and encapsulation."}, {"option_key": "D", "option_text": "It allows the class to inherit attributes from multiple parent classes.", "option_explanation": "This statement relates to multiple inheritance, which is a different concept and not directly tied to the reason for making instance variables private with getters/setters."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('9eacb988-f58b-494a-ab8f-c5e336824eb0', 'B', '[{"option_key": "A", "option_text": "To allow direct access from any other class in the program.", "option_explanation": "Incorrect. This describes the purpose of a `public` access modifier."}, {"option_key": "B", "option_text": "To restrict access to the member only from within its own class.", "option_explanation": "Correct! `private` members are only visible and accessible from code inside the class where they are declared."}, {"option_key": "C", "option_text": "To make the member automatically inherited by all subclasses.", "option_explanation": "Incorrect. While members can be inherited, `private` specifically restricts direct access, even by subclasses."}, {"option_key": "D", "option_text": "To mark the member as a constant value that cannot be changed.", "option_explanation": "Incorrect. This describes the purpose of keywords like `final` or `const`, not `private`."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('6f6cc360-0752-4cdd-ac2f-cbe201f5c9db', 'C', '[{"option_key": "A", "option_text": "`private`", "option_explanation": "Incorrect. If the methods were `private`, no other class could call them to interact with the `balance`."}, {"option_key": "B", "option_text": "`protected`", "option_explanation": "Incorrect. `protected` allows access by subclasses, but `public` is typically used for general external interaction."}, {"option_key": "C", "option_text": "`public`", "option_explanation": "Correct! `public` methods provide the necessary interface for other objects to safely interact with and modify the `private` attribute."}, {"option_key": "D", "option_text": "No access modifier is needed.", "option_explanation": "Incorrect. Omitting an access modifier might lead to default behavior, but explicit `public` is needed for clear, universal external access."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('aeb0e446-b9bc-4b30-8c4d-613ebc224f6d', 'B', '[{"option_key": "A", "option_text": "Allowing any part of the program to modify the attribute freely.", "option_explanation": "Incorrect. This would decrease data integrity by allowing uncontrolled modifications."}, {"option_key": "B", "option_text": "Ensuring that the attribute can only be accessed or modified through controlled methods within its own class.", "option_explanation": "Correct! By forcing interactions through methods, the class can validate inputs and maintain data consistency."}, {"option_key": "C", "option_text": "Making the attribute read-only from all external classes, preventing any modification.", "option_explanation": "Incorrect. While `private` restricts direct modification, it doesn''t necessarily make it read-only if public setter methods exist."}, {"option_key": "D", "option_text": "Improving the program''s execution speed due to reduced access overhead.", "option_explanation": "Incorrect. Access modifiers primarily deal with visibility and control, not execution speed optimization."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('034177ba-c716-4b8b-9aa9-701cc0ce112b', 'B', '[{"option_key": "A", "option_text": "To make the code compile faster.", "option_explanation": "Incorrect. Class naming conventions are not designed to influence compilation speed."}, {"option_key": "B", "option_text": "To enhance **clarity**, **identification**, and adherence to **language-specific requirements**.", "option_explanation": "Correct. Effective naming ensures a class is easily understood, identifiable, and follows necessary language rules."}, {"option_key": "C", "option_text": "To automatically generate documentation.", "option_explanation": "Incorrect. While good naming supports documentation, it does not automatically generate it."}, {"option_key": "D", "option_text": "To reduce the number of attributes in the class.", "option_explanation": "Incorrect. Class naming conventions are unrelated to the number of attributes a class contains."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('d92a884e-c219-4d88-a84f-8681d8942417', 'C', '[{"option_key": "A", "option_text": "It must be written in all uppercase letters.", "option_explanation": "Incorrect. This is a common convention for constants, not class names."}, {"option_key": "B", "option_text": "It must be the same as the package name.", "option_explanation": "Incorrect. Package names are used for organizing classes, not for matching class names directly."}, {"option_key": "C", "option_text": "It must **match the filename** for compilation.", "option_explanation": "Correct. In Java, a `public` class name must be identical to the `.java` filename for the compiler to process it."}, {"option_key": "D", "option_text": "It must end with \"Class\".", "option_explanation": "Incorrect. This is not a language requirement, though some projects might adopt it as a convention."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('55ada1c2-5737-4948-a950-37aa8531ca4b', 'C', '[{"option_key": "A", "option_text": "Design all possible public methods upfront to cover all foreseeable future needs.", "option_explanation": "Incorrect. This approach can lead to unnecessary complexity and contradicts the ''minimal initially'' aspect."}, {"option_key": "B", "option_text": "Begin by making all methods private and then gradually make them public as needed.", "option_explanation": "While it emphasizes control, the core principle specifies ''minimal public methods'' initially, not necessarily starting all as private."}, {"option_key": "C", "option_text": "**Initially design a class with minimal public methods** and iteratively add more only when explicitly required.", "option_explanation": "Correct. This ensures the interface remains focused on absolute necessities, with expansion driven by confirmed requirements or feedback."}, {"option_key": "D", "option_text": "Implement comprehensive error handling for every method regardless of its intended visibility.", "option_explanation": "Incorrect. While good practice, this is not the core application step for defining the scope of the public interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('25d4205b-69da-4b39-9abb-adfc2dc6b4a0', 'C', '[{"option_key": "A", "option_text": "To expose all internal methods to facilitate debugging.", "option_explanation": "Incorrect. Exposing all internal methods goes against the principle of minimalism and data control."}, {"option_key": "B", "option_text": "To allow direct access to all class attributes for ease of use.", "option_explanation": "Incorrect. Direct access to attributes contradicts the goals of security and controlled interaction."}, {"option_key": "C", "option_text": "To provide only the functionalities that external users **absolutely need** to interact with the class.", "option_explanation": "Correct. This principle ensures that only essential functionalities are exposed, simplifying usage and enhancing security."}, {"option_key": "D", "option_text": "To design the class to be compatible with all possible programming languages.", "option_explanation": "Incorrect. While compatibility is important, it is not the primary principle of a minimal public interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('894d1b82-5bdb-41b6-9f4b-d151ed535732', 'C', '[{"option_key": "A", "option_text": "Directly by external objects using the dot operator.", "option_explanation": "Incorrect. Private methods are inaccessible from outside the class, so they cannot be directly invoked by external objects."}, {"option_key": "B", "option_text": "Automatically by the system''s garbage collector when objects are no longer in use.", "option_explanation": "Incorrect. The garbage collector manages memory deallocation for objects, which is unrelated to method invocation."}, {"option_key": "C", "option_text": "Internally by the class''s public methods.", "option_explanation": "Correct. Private methods are helper functions called by public methods to handle specific internal tasks as part of a larger operation."}, {"option_key": "D", "option_text": "Through inheritance by a subclass, which then makes them public.", "option_explanation": "Incorrect. Private methods are not directly inherited by subclasses in a way that makes them public; they remain part of the superclass''s internal implementation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('e61c5e03-8ab6-4059-8d2c-bdfcc3dcc677', 'C', '[{"option_key": "A", "option_text": "Exposing all internal attributes as public to ensure maximum transparency.", "option_explanation": "Incorrect. Exposing all attributes violates data hiding and can lead to data integrity issues and difficult debugging."}, {"option_key": "B", "option_text": "Providing as many methods as possible to offer diverse functionality.", "option_explanation": "Incorrect. An excessive number of methods can lead to interface bloat and make the class harder to use and understand."}, {"option_key": "C", "option_text": "Designing interfaces to be as **minimal as possible**, revealing only what is absolutely necessary for users to interact with the class.", "option_explanation": "Correct! This practice adheres to the principle of information hiding and reduces complexity for the user, allowing for greater flexibility in internal implementation changes."}, {"option_key": "D", "option_text": "Making all methods private by default and only converting them to public upon specific user request.", "option_explanation": "While initial hiding can be part of the design, the core principle is to provide the minimal set of public interfaces from the outset, based on requirements, rather than a constantly changing public interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('623cccb4-d5b4-4c07-bbb3-630c195882cd', 'C', '[{"option_key": "A", "option_text": "A class defining an abstract method that subclasses must implement.", "option_explanation": "Incorrect. This describes an aspect of abstract classes or interfaces, not specifically composition."}, {"option_key": "B", "option_text": "A class inheriting attributes and methods from a superclass.", "option_explanation": "Incorrect. This describes inheritance, which represents an ''is-a'' relationship."}, {"option_key": "C", "option_text": "A class containing instances of other classes as its members.", "option_explanation": "Correct! Object composition is when one class is built by embedding instances of other classes within it."}, {"option_key": "D", "option_text": "A method calling another method within the same class.", "option_explanation": "Incorrect. This is a basic operation within a class, not a structural relationship between classes."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('bd4f3fc0-16c4-4c85-b70d-f2a8438fb86c', 'C', '[{"option_key": "A", "option_text": "To enable object-to-object communication.", "option_explanation": "This describes a concept primarily found in object-oriented programming, not the core purpose of functions in procedural programming."}, {"option_key": "B", "option_text": "To combine data and behaviors into a single entity.", "option_explanation": "This concept, known as encapsulation, is fundamental to object-oriented programming, not the primary role of functions in procedural programming."}, {"option_key": "C", "option_text": "To structure code into reusable blocks and manage complexity.", "option_explanation": "This is correct. Functions allow code to be organized into manageable, repeatable units, which improves readability and simplifies the overall program design."}, {"option_key": "D", "option_text": "To hide internal data from other parts of the program.", "option_explanation": "While functions can help with data management, their main purpose in procedural programming is not primarily data hiding, which is more strongly associated with object-oriented concepts."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('470e26d0-b23a-4e17-8832-e3fe831f1101', 'C', '[{"option_key": "A", "option_text": "It is accessible only within the function where it is declared.", "option_explanation": "This describes a local variable, whose scope is limited to the function in which it is defined."}, {"option_key": "B", "option_text": "It is automatically created and destroyed when a function is called.", "option_explanation": "This is a characteristic of local variables, which exist only during the execution of the function they belong to."}, {"option_key": "C", "option_text": "It can be accessed and modified by any function in the program.", "option_explanation": "This is correct. Global variables are typically declared outside functions, allowing widespread access and modification."}, {"option_key": "D", "option_text": "Its value cannot be changed after initialization.", "option_explanation": "This describes a constant variable, not a characteristic specific to global variables in procedural programming."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('dae4ec50-4cec-4d5f-8510-05d28dd1eb5e', 'C', '[{"option_key": "A", "option_text": "To allow direct access to sensitive data from outside the class.", "option_explanation": "Incorrect. Private methods are explicitly designed to prevent direct external access to internal data and logic."}, {"option_key": "B", "option_text": "To expose essential functionalities for external users.", "option_explanation": "Incorrect. Exposing functionalities for external users is the role of public methods, which form the class''s interface."}, {"option_key": "C", "option_text": "To encapsulate internal logic and helper functions not intended for direct external access.", "option_explanation": "Correct. Private methods serve to keep a class''s internal operations and helper tasks self-contained and hidden from external classes."}, {"option_key": "D", "option_text": "To define methods that can be inherited and directly called by subclasses.", "option_explanation": "Incorrect. While subclasses might indirectly trigger private methods by calling public methods, private methods themselves are not intended for direct inheritance and call by subclasses for external use."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('69ac3d23-f357-46eb-8f3d-bf9a2fd96a0b', 'B', '[{"option_key": "A", "option_text": "It allows the class to have more attributes.", "option_explanation": "Incorrect. The number of attributes a class can have is not directly related to the separation of its interface from its implementation."}, {"option_key": "B", "option_text": "It **hides internal details**, enabling the implementation to be modified without impacting external code that uses the interface.", "option_explanation": "Correct! This separation ensures that users of the class interact only with the public interface, making internal implementation changes transparent to them."}, {"option_key": "C", "option_text": "It makes the class run faster due to reduced code size.", "option_explanation": "Incorrect. While good design can have performance benefits, this is not the primary advantage of separating interface from implementation."}, {"option_key": "D", "option_text": "It enables a class to inherit from multiple superclasses.", "option_explanation": "Incorrect. The separation of interface from implementation is a distinct concept from multiple inheritance."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('232827d8-1365-4cf3-9f4e-8bb317b88d2f', 'C', '[{"option_key": "A", "option_text": "By significantly reducing the memory footprint of objects.", "option_explanation": "Incorrect. Polymorphism''s primary benefit is not memory reduction."}, {"option_key": "B", "option_text": "By ensuring that all methods have unique names across the entire system.", "option_explanation": "Incorrect. Method overriding specifically involves methods having the *same* name."}, {"option_key": "C", "option_text": "By enabling objects of different classes to be treated as objects of a common type, leading to enhanced flexibility and extensibility.", "option_explanation": "Correct. This allows for uniform handling of diverse objects and easy addition of new types."}, {"option_key": "D", "option_text": "By automatically generating new methods in subclasses, eliminating manual coding.", "option_explanation": "Incorrect. Polymorphism requires specific implementation in subclasses, not automatic generation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c5349080-b322-4f51-b497-dcb1738dd14a', 'C', '[{"option_key": "A", "option_text": "Method", "option_explanation": "Incorrect. Methods define an object''s behaviour, not its state data."}, {"option_key": "B", "option_text": "Class", "option_explanation": "Incorrect. A class is a blueprint for objects; it does not store data for a specific object instance."}, {"option_key": "C", "option_text": "Attribute", "option_explanation": "Correct! Attributes store the data that defines an object''s state."}, {"option_key": "D", "option_text": "Function", "option_explanation": "Incorrect. Functions are procedures, defining behaviour, not object state in OOP."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('5ea915ba-e221-46be-9b49-8308b5474914', 'C', '[{"option_key": "A", "option_text": "Inheritance, because a `Car` is a type of `Engine`.", "option_explanation": "Incorrect. A car is not a type of engine; this misapplies the ''is-a'' relationship for inheritance."}, {"option_key": "B", "option_text": "Association, implying a general connection between independent objects.", "option_explanation": "Incorrect. While a general connection exists, composition is a more specific and stronger ''has-a'' relationship suitable for integral components."}, {"option_key": "C", "option_text": "Composition, because a `Car` ''has a'' `Engine` and the `Engine` is an integral part of the `Car`''s structure and function.", "option_explanation": "Correct! This accurately represents the ''has-a'' relationship and the integral, dependent nature often associated with composition."}, {"option_key": "D", "option_text": "Aggregation, as an `Engine` can exist independently of a `Car`.", "option_explanation": "Incorrect. While an engine can exist independently, composition is typically used for components that are integral to the whole''s functionality, and whose lifecycle might be strongly tied to the whole (e.g., specific engine for a specific car)."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('055064e7-0ec4-47ef-843d-52d3caa042d9', 'C', '[{"option_key": "A", "option_text": "To make the function run faster.", "option_explanation": "Parameter passing is not primarily for performance optimization."}, {"option_key": "B", "option_text": "To define the function''s return type.", "option_explanation": "The return type is part of the function''s declaration, not directly related to parameter passing itself."}, {"option_key": "C", "option_text": "To allow data to be passed into or out of the function in a controlled manner.", "option_explanation": "This is correct. Parameters enable explicit and controlled communication of data between different functions."}, {"option_key": "D", "option_text": "To declare local variables within the function.", "option_explanation": "Local variables are declared inside the function body and are separate from parameters, though parameters can act like local variables within the function''s scope."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('76fbb78a-6ad3-4901-b3b6-47992175ff8b', 'C', '[{"option_key": "A", "option_text": "Private methods define the public interface, while public methods implement the internal logic.", "option_explanation": "Incorrect. This reverses the roles. Public methods define the interface, and private methods encapsulate internal logic."}, {"option_key": "B", "option_text": "Both private and public methods are part of the public interface, but private methods are optional.", "option_explanation": "Incorrect. Only public methods are part of the public interface. Private methods are strictly hidden from it."}, {"option_key": "C", "option_text": "Private methods are part of the class''s internal implementation, hidden from the public interface, which exposes only what external users need.", "option_explanation": "Correct. This statement accurately reflects that private methods are internal and hidden, while the public interface provides essential external interaction."}, {"option_key": "D", "option_text": "The public interface specifies what private methods must be implemented for external interaction.", "option_explanation": "Incorrect. The public interface specifies how external users interact with public methods, not which private methods must be implemented or how they interact externally."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('f61ab599-ae39-4ee8-923e-62a23468e185', 'B', '[{"option_key": "A", "option_text": "Defining multiple methods with the same name but different parameters within a single class.", "option_explanation": "Incorrect. This describes method overloading, not overriding."}, {"option_key": "B", "option_text": "A subclass providing its own specific implementation for a method that is already defined in its superclass.", "option_explanation": "Correct. Method overriding occurs when a subclass gives a unique implementation for a method inherited from its superclass."}, {"option_key": "C", "option_text": "Calling a method from another object to perform an action.", "option_explanation": "Incorrect. This describes method invocation or message passing, not overriding."}, {"option_key": "D", "option_text": "Creating a new method in a subclass that has no relation to methods in the superclass.", "option_explanation": "Incorrect. This is simply creating a new method, not overriding an existing one."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('b6fce91c-fb87-4d57-856d-5f57704256a2', 'D', '[{"option_key": "A", "option_text": "Association", "option_explanation": "Incorrect. Association is a general relationship without a strong dependency, often represented by a simple line."}, {"option_key": "B", "option_text": "Aggregation", "option_explanation": "Incorrect. Aggregation implies a \"has-a\" relationship, where a part can exist independently of the whole, shown with a hollow diamond."}, {"option_key": "C", "option_text": "Composition", "option_explanation": "Incorrect. Composition implies a strong \"has-a\" relationship, where parts cannot exist without the whole, shown with a filled diamond."}, {"option_key": "D", "option_text": "Inheritance", "option_explanation": "Correct! This symbol represents that a subclass derives properties and behaviours from a superclass."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('5fe02d93-b135-4d8e-9c84-f01df5cda967', 'C', '[{"option_key": "A", "option_text": "```java\nclass Animal {\n    void speak() { /* ... */ }\n}\nclass Dog {\n    void bark() { /* ... */ }\n}\n```", "option_explanation": "Incorrect. This shows two unrelated classes with different method names, not overriding."}, {"option_key": "B", "option_text": "```java\nclass Calculator {\n    int add(int a, int b) { return a + b; }\n    double add(double a, double b) { return a + b; }\n}\n```", "option_explanation": "Incorrect. This demonstrates method overloading (same name, different parameters), not overriding."}, {"option_key": "C", "option_text": "```java\nclass Vehicle {\n    void move() { System.out.println(\"Vehicle moves\"); }\n}\nclass Car extends Vehicle {\n    @Override\n    void move() { System.out.println(\"Car drives\"); }\n}\n```", "option_explanation": "Correct. The `Car` subclass extends `Vehicle` and provides its own implementation for the `move()` method, which is defined in `Vehicle`."}, {"option_key": "D", "option_text": "```java\nclass Shape {\n    int sides;\n}\nclass Square extends Shape {\n    // No methods shown\n}\n```", "option_explanation": "Incorrect. This shows inheritance of attributes but no method, and thus no method overriding."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('5a588477-68c4-4f97-b636-85daa7ce6e62', 'C', '[{"option_key": "A", "option_text": "Directly accessing `person.age`", "option_explanation": "Incorrect. Direct access to `private` attributes is not allowed in Java due to encapsulation."}, {"option_key": "B", "option_text": "Calling a `setAge()` method", "option_explanation": "Incorrect. A `setAge()` method is used to modify the attribute''s value, not retrieve it."}, {"option_key": "C", "option_text": "Calling a `getAge()` method", "option_explanation": "Correct! Accessor methods (getters) provide controlled read-only access to private attributes."}, {"option_key": "D", "option_text": "Using a `public` variable `age`", "option_explanation": "Incorrect. Declaring attributes `public` breaks data hiding and is generally not good practice for state data."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('44cd4a6c-057f-46f9-8b4c-485a3f90977c', 'C', '[{"option_key": "A", "option_text": "A simple solid line between `Car` and `Engine`.", "option_explanation": "Incorrect. A simple line represents a general association, not specifically composition."}, {"option_key": "B", "option_text": "A solid line with a **hollow diamond** on the `Car` end.", "option_explanation": "Incorrect. A hollow diamond represents aggregation, which is a weaker \"has-a\" relationship where the part can exist independently."}, {"option_key": "C", "option_text": "A solid line with a **filled diamond** on the `Car` end.", "option_explanation": "Correct! A filled diamond denotes composition, indicating a strong lifecycle dependency where the part cannot exist without the whole."}, {"option_key": "D", "option_text": "A dashed line with a hollow triangular arrowhead on the `Engine` end.", "option_explanation": "Incorrect. This symbol represents an interface implementation or realisation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('a324b912-609f-41a2-b23b-bf4f57b41f6b', 'D', '[{"option_key": "A", "option_text": "Child class", "option_explanation": "Incorrect. A child class is the one that inherits, not the one from which it inherits."}, {"option_key": "B", "option_text": "Derived class", "option_explanation": "Incorrect. A derived class is another name for a subclass, which inherits from another class."}, {"option_key": "C", "option_text": "Subclass", "option_explanation": "Incorrect. A subclass is the one that inherits, not the one that provides the inheritance."}, {"option_key": "D", "option_text": "Superclass", "option_explanation": "Correct! A superclass provides attributes and methods to be inherited by other classes."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('551de974-c017-4509-b750-9ca4486c87a1', 'C', '[{"option_key": "A", "option_text": "Base class", "option_explanation": "Incorrect. A base class is another name for a superclass."}, {"option_key": "B", "option_text": "Parent class", "option_explanation": "Incorrect. A parent class is another name for a superclass."}, {"option_key": "C", "option_text": "Subclass", "option_explanation": "Correct! A subclass extends a superclass and inherits its features."}, {"option_key": "D", "option_text": "Superclass", "option_explanation": "Incorrect. A superclass is the class that is extended, not the one that extends."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('754062c6-e890-40c2-8797-da3981b03891', 'C', '[{"option_key": "A", "option_text": "By declaring new local variables within the function''s body.", "option_explanation": "Declaring local variables happens inside a function but does not invoke it."}, {"option_key": "B", "option_text": "By defining the function''s return type and parameters.", "option_explanation": "This describes the function definition, not its invocation."}, {"option_key": "C", "option_text": "By referencing its name followed by parentheses containing any required arguments.", "option_explanation": "This is correct. To execute a function, its name is used, and actual values (arguments) are passed inside the parentheses."}, {"option_key": "D", "option_text": "By modifying its internal algorithms or logic.", "option_explanation": "Modifying internal logic changes what a function does, but it does not invoke it."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('08b82dca-6f46-4031-ae2d-cdd78ff09208', 'C', '[{"option_key": "A", "option_text": "Data and operations are encapsulated within objects.", "option_explanation": "Incorrect. This describes a characteristic of object-oriented programming (OOP), not procedural programming."}, {"option_key": "B", "option_text": "Operations are defined as methods within data structures.", "option_explanation": "Incorrect. This is a concept related to object-oriented programming where methods operate directly on their encapsulated data."}, {"option_key": "C", "option_text": "Data is separated from functions or procedures that manipulate it.", "option_explanation": "Correct! In procedural programming, data typically resides in separate structures from the functions or procedures that operate on it."}, {"option_key": "D", "option_text": "Data is hidden, and operations are exposed through public interfaces.", "option_explanation": "Incorrect. Data hiding and public interfaces are key principles of encapsulation in object-oriented programming."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('42d721b7-52d0-4bdd-a356-d5a0218cc5cd', 'C', '[{"option_key": "A", "option_text": "```java\nclass Car {\n  Engine engine = new Engine();\n}\n```", "option_explanation": "Incorrect. This snippet demonstrates composition, an object-oriented concept where one object contains another."}, {"option_key": "B", "option_text": "```java\ninterface Drivable {\n  void drive();\n}\n```", "option_explanation": "Incorrect. This shows an interface, a concept used in object-oriented programming to define contracts for behavior."}, {"option_key": "C", "option_text": "```java\npublic class Calculator {\n  public static void main(String args[]) {\n    int result = 0;\n    for (int i = 0; i < 5; i++) {\n      result += i;\n    }\n    System.out.println(result);\n  }\n}\n```", "option_explanation": "Correct! This code features sequential execution, a condition (`i < 5`), and iteration (`for` loop), which are fundamental constructs of procedural programming."}, {"option_key": "D", "option_text": "```java\nclass Dog extends Mammal {\n  // methods and attributes\n}\n```", "option_explanation": "Incorrect. This demonstrates inheritance, a core principle of object-oriented programming where one class acquires properties from another."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('3db7efa0-4a2a-48bb-8db1-a5cef534a60c', 'B', '[{"option_key": "A", "option_text": "Data is exclusively accessed through well-defined object interfaces.", "option_explanation": "Incorrect. This describes a controlled access mechanism common in object-oriented programming."}, {"option_key": "B", "option_text": "Data is often global, allowing multiple functions to directly modify it.", "option_explanation": "Correct! Procedural programming frequently uses global data, making it directly accessible and modifiable by many different functions."}, {"option_key": "C", "option_text": "Each function maintains its own encapsulated copy of all necessary data.", "option_explanation": "Incorrect. This reflects data encapsulation, which is a principle of object-oriented programming."}, {"option_key": "D", "option_text": "Data access is strictly controlled and predictable, preventing external modification.", "option_explanation": "Incorrect. This is an ideal state of data integrity, which is harder to achieve with global data in procedural programming."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('70e7ec3d-fd9c-40db-b124-8bb514e395c6', 'B', '[{"option_key": "A", "option_text": "Procedural programming focuses on functions and procedures, while OOP only uses global variables.", "option_explanation": "Incorrect. Procedural programming does focus on functions, but OOP does not solely rely on global variables; in fact, it minimizes them."}, {"option_key": "B", "option_text": "In procedural programming, data is separated from the functions that operate on it, whereas in OOP, data (attributes) and operations (methods) are encapsulated within a single object.", "option_explanation": "Correct! Procedural programming treats data and functions as distinct, while OOP combines them within an object through encapsulation, providing controlled access."}, {"option_key": "C", "option_text": "OOP uses a top-down design approach, while procedural programming uses a bottom-up approach.", "option_explanation": "Incorrect. The design approaches are more nuanced; OOP focuses on object interactions, and procedural is often top-down."}, {"option_key": "D", "option_text": "Procedural programming emphasizes code reuse through inheritance, while OOP uses only composition.", "option_explanation": "Incorrect. OOP uses both inheritance and composition for reuse. Procedural programming supports reuse primarily through functions, not inheritance."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('5054929b-6006-4469-851a-83ed99b73024', 'B', '[{"option_key": "A", "option_text": "```java\nint employeeAge;\nvoid setEmployeeAge(int age) {\n    employeeAge = age;\n}\n```", "option_explanation": "Incorrect. While it shows a function setting data, the data `employeeAge` is not declared within a class, which is typical of procedural thinking rather than object-oriented encapsulation."}, {"option_key": "B", "option_text": "```java\nclass Employee {\n    private String name;\n    public String getName() {\n        return name;\n    }\n    public void setName(String newName) {\n        name = newName;\n    }\n}\n```", "option_explanation": "Correct! This snippet demonstrates encapsulation by making the `name` attribute private and providing public methods (`getName`, `setName`) for controlled access, a core OOP principle of modularity."}, {"option_key": "C", "option_text": "```java\npublic class Main {\n    public static void main(String[] args) {\n        int counter = 0;\n        for (int i = 0; i < 10; i++) {\n            counter++;\n        }\n    }\n}\n```", "option_explanation": "Incorrect. This is an example of structured programming (a loop) within an OOP language, but it doesn''t primarily demonstrate encapsulation or class-level modularity principles."}, {"option_key": "D", "option_text": "```java\nclass Payroll {\n    void processPay(Employee emp) {\n        // ... logic ...\n    }\n}\n```", "option_explanation": "Incorrect. This shows interaction between objects but doesn''t explicitly highlight how data and behavior are encapsulated within the `Payroll` class itself or contrast with procedural data handling."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('1cbef223-4c02-4664-98cf-90fe1489efd9', 'C', '[{"option_key": "A", "option_text": "Creating a single `Utility` class that contains methods for data validation, database logging, and user interface updates.", "option_explanation": "Incorrect. This `Utility` class has multiple reasons to change (data validation logic, logging mechanism, UI updates), violating SRP."}, {"option_key": "B", "option_text": "Designing a `ReportGenerator` class to handle both data retrieval and the formatting of the report (e.g., PDF, HTML).", "option_explanation": "Incorrect. The `ReportGenerator` would have two reasons to change: if the data retrieval logic changes, or if the report format changes. SRP suggests separating these concerns."}, {"option_key": "C", "option_text": "Separating a `CustomerManagement` class into a `CustomerData` class (for attributes and data persistence) and a `CustomerValidator` class (for validation logic).", "option_explanation": "Correct! This adheres to SRP by assigning distinct responsibilities (data handling/persistence and validation) to separate classes, meaning each class has only one reason to change."}, {"option_key": "D", "option_text": "Using global variables to allow different modules to easily share data across the entire application.", "option_explanation": "Incorrect. Global variables are a procedural concept that often leads to uncontrolled data access and reduced modularity, directly opposing OOP principles like SRP and encapsulation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('d5c9571a-9707-4d05-8367-5e6bb8ec7719', 'B', '[{"option_key": "A", "option_text": "A specific, tangible instance of an entity in a program.", "option_explanation": "Incorrect. This describes an object, which is an instance of a class."}, {"option_key": "B", "option_text": "A blueprint or template used for creating objects.", "option_explanation": "Correct! A class acts as a blueprint, defining the common structure and behaviour for all its objects."}, {"option_key": "C", "option_text": "A block of executable code designed for a single task.", "option_explanation": "Incorrect. This sounds more like a method or function within a class."}, {"option_key": "D", "option_text": "A primitive data type used for storing simple values.", "option_explanation": "Incorrect. Classes define complex, custom data types, unlike primitive types."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c4604a3f-2f58-4b67-9861-fa794e41648e', 'B', '[{"option_key": "A", "option_text": "```java\npublic Bicycle() {\n    // constructor\n}\n```", "option_explanation": "Incorrect. This snippet defines a constructor, not a class."}, {"option_key": "B", "option_text": "```java\nclass Bicycle {\n    // class body\n}\n```", "option_explanation": "Correct! This uses the ''class'' keyword and curly braces for a valid class declaration."}, {"option_key": "C", "option_text": "```java\ncreate Bicycle;\n```", "option_explanation": "Incorrect. ''create'' is not the keyword for class declaration in Java."}, {"option_key": "D", "option_text": "```java\nobject Bicycle = new object();\n```", "option_explanation": "Incorrect. This is for object instantiation, not class declaration."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('641d22e9-e90b-45b9-9d56-6a9f070ff803', 'B', '[{"option_key": "A", "option_text": "To define actions an object can perform.", "option_explanation": "Incorrect. Actions an object can perform are typically defined by methods."}, {"option_key": "B", "option_text": "To store data unique to each object instance.", "option_explanation": "Correct! Attributes are variables that hold data specific to individual objects, defining their unique state."}, {"option_key": "C", "option_text": "To specify how objects communicate with each other.", "option_explanation": "Incorrect. Communication between objects is typically handled through method calls or messages."}, {"option_key": "D", "option_text": "To determine the overall structure of the program.", "option_explanation": "Incorrect. While classes contribute to program structure, attributes specifically define the data part of an object''s structure."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('991d1199-22ac-4eae-8e19-ae8239fd40c6', 'D', '[{"option_key": "A", "option_text": "It is a definition of shared behaviors for a group of classes.", "option_explanation": "Incorrect. This describes an interface or a superclass."}, {"option_key": "B", "option_text": "It is the source code file that contains a class definition.", "option_explanation": "Incorrect. The source code file is where the class is defined, not the object itself."}, {"option_key": "C", "option_text": "It is a general concept that groups related data and functions.", "option_explanation": "Incorrect. This is a description of a class."}, {"option_key": "D", "option_text": "It is a specific instance of a class, with its own unique state.", "option_explanation": "Correct! An object is a concrete realization of a class, holding particular values for its attributes."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('7b000bc3-6a3a-4fe4-80d1-96340d071514', 'C', '[{"option_key": "A", "option_text": "```python\nclass Car:\n    colour = ''blue''\n```", "option_explanation": "Incorrect. This defines a class attribute, which is shared by all instances, not an instance-specific attribute upon initialisation."}, {"option_key": "B", "option_text": "```python\nclass Car:\n    def set_colour(self, c):\n        self.colour = c\n```", "option_explanation": "Incorrect. This defines a setter method, which modifies an attribute, but doesn''t show how it''s initially defined during object creation."}, {"option_key": "C", "option_text": "```python\nclass Car:\n    def __init__(self):\n        self.colour = ''blue''\n```", "option_explanation": "Correct! The `__init__` method is automatically called when a new `Car` object is created, and `self.colour = ''blue''` correctly defines an instance attribute."}, {"option_key": "D", "option_text": "```python\nclass Car:\n    def paint(self):\n        self.colour = ''blue''\n```", "option_explanation": "Incorrect. This defines a regular method that sets the colour, but it''s not the standard way to initialise an object''s attribute when it''s first created."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('db7a1347-ee38-4496-bc72-e4b2ade0802a', 'C', '[{"option_key": "A", "option_text": "A specific piece of data, such as a number or a string.", "option_explanation": "Incorrect. Data values are typically stored within objects as attributes."}, {"option_key": "B", "option_text": "An action or behavior that an object can perform.", "option_explanation": "Incorrect. Actions are defined by methods, which are part of a class."}, {"option_key": "C", "option_text": "A blueprint or template for creating objects.", "option_explanation": "Correct! A class defines the structure and behavior for objects created from it."}, {"option_key": "D", "option_text": "A running program or application.", "option_explanation": "Incorrect. A program is composed of many interacting classes and objects, but a class itself is not the entire program."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('bfdd8e8f-85c3-488b-81b9-8615e8433fd2', 'B', '[{"option_key": "A", "option_text": "A subclass overriding a method from its superclass to provide a specific implementation.", "option_explanation": "Incorrect. This describes polymorphism and inheritance, not a direct benefit of encapsulation related to internal changes."}, {"option_key": "B", "option_text": "A developer changing the internal data structure of a `Product` class without affecting other parts of the system that use its public `getPrice()` method.", "option_explanation": "Correct! This demonstrates how encapsulation, through data hiding and a consistent public interface, allows internal changes without breaking external client code, enhancing maintainability and preventing unintended side effects."}, {"option_key": "C", "option_text": "Creating multiple instances of the same `Car` class, each with unique attributes.", "option_explanation": "Incorrect. This illustrates object instantiation, not a primary benefit of encapsulation itself."}, {"option_key": "D", "option_text": "Using a shared utility method across different classes to perform a common mathematical calculation.", "option_explanation": "Incorrect. This describes code reuse through static methods or utility classes, which is not a direct benefit of encapsulation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('f9d89576-54c8-47f1-9d8d-2333734b65f8', 'C', '[{"option_key": "A", "option_text": "To reduce the overall number of classes in the system.", "option_explanation": "Incorrect. The primary goal is not simply to reduce class count, but to ensure proper design principles."}, {"option_key": "B", "option_text": "To prevent all classes from being abstract.", "option_explanation": "Incorrect. While abstract classes are related to inheritance, this is not the main reason for distinguishing between ''is-a'' and ''has-a''."}, {"option_key": "C", "option_text": "To ensure the system is flexible, maintainable, and robust.", "option_explanation": "Correct! Choosing the appropriate relationship (`is-a` for type specialisation or `has-a` for component inclusion) directly impacts these crucial design qualities."}, {"option_key": "D", "option_text": "To strictly adhere to procedural programming paradigms.", "option_explanation": "Incorrect. Differentiating these relationships is fundamental to object-oriented, not procedural, design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c8a305aa-31e5-491e-a959-134250d5b766', 'D', '[{"option_key": "A", "option_text": "To create a new instance of the class.", "option_explanation": "Incorrect. Object instantiation is typically done using keywords like `new` with a constructor, not by invoking a regular method."}, {"option_key": "B", "option_text": "To define the blueprint for new objects.", "option_explanation": "Incorrect. Defining a blueprint is the role of a class, not a method invocation."}, {"option_key": "C", "option_text": "To directly access and modify the object''s private data.", "option_explanation": "Incorrect. Methods provide controlled access to an object''s data; direct access to private data is generally restricted by encapsulation."}, {"option_key": "D", "option_text": "To execute a specific behavior or action defined for that object.", "option_explanation": "Correct! Invoking a method triggers the execution of the code defining a specific behavior for that object instance."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('748d25c9-32a2-4d0e-80d3-c0ecd4f2bea1', 'B', '[{"option_key": "A", "option_text": "`myAccount.balance += 100;`", "option_explanation": "Incorrect. This attempts direct access and modification of a `private` attribute, which violates encapsulation."}, {"option_key": "B", "option_text": "`myAccount.deposit(100);`", "option_explanation": "Correct! This uses a public method, `deposit()`, to provide controlled modification of the `private` `balance` attribute, adhering to encapsulation."}, {"option_key": "C", "option_text": "`BankAccount.setBalance(myAccount, 100);`", "option_explanation": "Incorrect. This syntax suggests a static method attempting to set a specific instance''s balance directly, which is not how object methods are typically invoked for an instance."}, {"option_key": "D", "option_text": "`System.out.println(myAccount.balance);`", "option_explanation": "Incorrect. This attempts direct access to a `private` attribute and is used for printing a value, not for depositing funds."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('d1548300-b2e3-4ebd-81b6-90b5fa8a1bd1', 'B', '[{"option_key": "A", "option_text": "A class can implement multiple abstract classes but only extend a single interface.", "option_explanation": "Incorrect. The roles are reversed; a class extends classes and implements interfaces."}, {"option_key": "B", "option_text": "A class can extend only one abstract class, but it can implement multiple interfaces.", "option_explanation": "Correct! Java supports single inheritance for classes (extending one abstract or concrete class) but allows a class to implement any number of interfaces."}, {"option_key": "C", "option_text": "A class can extend multiple abstract classes and implement multiple interfaces.", "option_explanation": "Incorrect. Java does not support multiple inheritance for classes, meaning a class cannot extend multiple abstract classes."}, {"option_key": "D", "option_text": "A class can neither extend multiple abstract classes nor implement multiple interfaces.", "option_explanation": "Incorrect. A class can implement multiple interfaces."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('50415c83-29fd-4fcf-b5b7-0b79a5e981f1', 'D', '[{"option_key": "A", "option_text": "`Light.turnOn();`", "option_explanation": "Incorrect. This syntax might be used for static methods or to refer to the class, not for invoking a method on a specific object instance."}, {"option_key": "B", "option_text": "`new myLight.turnOn();`", "option_explanation": "Incorrect. The `new` keyword is used for creating new objects (instantiation), not for invoking methods on existing ones."}, {"option_key": "C", "option_text": "`myLight.turnOn;`", "option_explanation": "Incorrect. This syntax attempts to access `turnOn` as an attribute or property, not to invoke it as a method (which requires parentheses)."}, {"option_key": "D", "option_text": "`myLight.turnOn();`", "option_explanation": "Correct! This is the standard syntax for invoking a method on an object, using the object''s name followed by a dot, the method name, and parentheses."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('084f878a-7169-4b31-b2e6-01cef6130a4c', 'B', '[{"option_key": "A", "option_text": "To allow direct modification by any external class.", "option_explanation": "Incorrect. The `private` modifier restricts, rather than allows, direct external modification."}, {"option_key": "B", "option_text": "To make the variable accessible only within the class where it is declared.", "option_explanation": "Correct! Declaring a variable as `private` ensures that only methods belonging to that specific class can directly access or modify it."}, {"option_key": "C", "option_text": "To enable inheritance of the variable by subclasses.", "option_explanation": "Incorrect. While subclasses conceptually inherit private members, they cannot directly access them; access must be through public or protected methods of the superclass."}, {"option_key": "D", "option_text": "To make the variable a global constant accessible throughout the program.", "option_explanation": "Incorrect. `private` restricts scope, and constants are typically declared using `final` (or `const`) and often `static`."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('a8aa6b6b-3b3a-402e-8e43-3e3442a4726f', 'B', '[{"option_key": "A", "option_text": "When a group of closely related classes needs to share a common base implementation.", "option_explanation": "Incorrect. This scenario is better suited for an abstract class, which provides partial implementations and a common base."}, {"option_key": "B", "option_text": "When unrelated classes need to guarantee they possess a specific set of behaviours or capabilities.", "option_explanation": "Correct! Interfaces are ideal for defining contracts that unrelated classes can fulfil, ensuring they provide a specific set of capabilities without forcing a common inheritance hierarchy."}, {"option_key": "C", "option_text": "When strict single inheritance is required to model an ''is-a'' relationship.", "option_explanation": "Incorrect. Single inheritance for an ''is-a'' relationship is a characteristic of abstract classes (or concrete classes), not interfaces."}, {"option_key": "D", "option_text": "When the goal is to provide a complete, non-extensible implementation of a base class.", "option_explanation": "Incorrect. Neither interfaces nor abstract classes are used for providing complete, non-extensible implementations. Interfaces are for contracts, and abstract classes are for extensible bases."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('e030ecb9-d2ae-43d6-8243-f6730a1aed24', 'B', '[{"option_key": "A", "option_text": "To allow direct access to all internal data for flexibility.", "option_explanation": "Incorrect. Encapsulation aims to restrict direct access to internal data, promoting data protection and integrity."}, {"option_key": "B", "option_text": "To bundle an object''s data and methods, while controlling access to its internal details.", "option_explanation": "Correct! Encapsulation combines data and the methods that operate on that data into a single unit, and hides the internal workings from outside access."}, {"option_key": "C", "option_text": "To enable a class to inherit attributes and methods from another class.", "option_explanation": "Incorrect. This describes inheritance, which is a different core OOP principle from encapsulation."}, {"option_key": "D", "option_text": "To allow objects of different types to respond to the same message in unique ways.", "option_explanation": "Incorrect. This describes polymorphism, a different core OOP concept."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('e0b91709-8c8d-4396-8aae-1aec1b66fdd7', 'B', '[{"option_key": "A", "option_text": "A ''has-a'' relationship", "option_explanation": "Incorrect. A ''has-a'' relationship implies one object contains another, like a Car has an Engine, not that one *is* a type of the other."}, {"option_key": "B", "option_text": "An ''is-a'' relationship", "option_explanation": "Correct! An ''is-a'' relationship is fundamental to inheritance, where a subclass is a specialised type of its superclass."}, {"option_key": "C", "option_text": "A ''uses-a'' relationship", "option_explanation": "Incorrect. A ''uses-a'' relationship suggests one class interacts with another, but doesn''t define a hierarchical type relationship."}, {"option_key": "D", "option_text": "A ''part-of'' relationship", "option_explanation": "Incorrect. A ''part-of'' relationship indicates composition, where one object is a component of another, rather than being a subtype."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('1ba54d58-cac1-4184-b94b-c06dc6b28210', 'C', '[{"option_key": "A", "option_text": "An abstract class can only define abstract methods, whereas an interface can define both abstract and concrete methods.", "option_explanation": "Incorrect. This statement reverses the capabilities of abstract classes and interfaces."}, {"option_key": "B", "option_text": "An interface can provide full implementations for some methods, while an abstract class can only provide method signatures.", "option_explanation": "Incorrect. Interfaces define method signatures without implementations. Abstract classes can provide full implementations."}, {"option_key": "C", "option_text": "An abstract class can have concrete (implemented) methods, whereas an interface can only have abstract (unimplemented) methods.", "option_explanation": "Correct! Abstract classes allow for partial implementation, providing concrete methods alongside abstract ones. Interfaces only declare method signatures without implementation."}, {"option_key": "D", "option_text": "Neither an abstract class nor an interface can contain any method implementations.", "option_explanation": "Incorrect. Abstract classes can contain method implementations."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('f06dfa92-fc5a-4a8f-8b50-045720cf54ce', 'B', '[{"option_key": "A", "option_text": "```java\nclass Vehicle extends Car {\n    // ...\n}\n```", "option_explanation": "Incorrect. This code demonstrates an ''is-a'' (inheritance) relationship, where `Vehicle` extends `Car`."}, {"option_key": "B", "option_text": "```java\nclass Car {\n    private Engine engine; // Car has an Engine\n    public Car() {\n        this.engine = new Engine();\n    }\n}\n```", "option_explanation": "Correct! The `Car` class contains an `Engine` object as an attribute, signifying a ''has-a'' (composition) relationship."}, {"option_key": "C", "option_text": "```java\ninterface Drivable {\n    void drive();\n}\nclass Car implements Drivable {\n    // ...\n}\n```", "option_explanation": "Incorrect. This shows a class implementing an interface, which defines a contract for behaviour, not a ''has-a'' relationship."}, {"option_key": "D", "option_text": "```java\npublic void startCar(Car car) {\n    car.start();\n}\n```", "option_explanation": "Incorrect. This depicts a method taking a `Car` object as a parameter, representing object interaction, not a structural ''has-a'' relationship."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('cc00c356-dbee-4e3f-9cb0-b44eda2e3e4b', 'C', '[{"option_key": "A", "option_text": "A planned pause in program execution for user input.", "option_explanation": "Incorrect. Exceptions are unexpected, not planned pauses."}, {"option_key": "B", "option_text": "A syntax error detected by the compiler before runtime.", "option_explanation": "Incorrect. Exceptions occur during program execution, not at compile time for syntax errors."}, {"option_key": "C", "option_text": "An unexpected event that occurs during program execution.", "option_explanation": "Correct! Exceptions are defined as unexpected events during program execution."}, {"option_key": "D", "option_text": "A special type of function call for debugging purposes.", "option_explanation": "Incorrect. While debugging might involve exceptions, their primary definition is not a function call."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('cb717fe1-74c8-4971-b740-d2d652dd1c41', 'C', '[{"option_key": "A", "option_text": "It defines the code that is guaranteed to execute whether an exception occurs or not.", "option_explanation": "Incorrect. This describes a `finally` block, which is not part of this Knowledge Component."}, {"option_key": "B", "option_text": "It contains the code that is expected to throw an exception.", "option_explanation": "Incorrect. This describes a `try` block."}, {"option_key": "C", "option_text": "It specifies the type of exception to be handled and contains code to respond to it.", "option_explanation": "Correct! A `catch` block is used to handle specific exceptions that are thrown from within the associated `try` block."}, {"option_key": "D", "option_text": "It explicitly terminates the program when an error is detected.", "option_explanation": "Incorrect. The goal of a `catch` block is often to prevent termination or allow a graceful exit, not to force termination."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('2b12a446-4220-4cfc-b4de-debe9ba0350a', 'C', '[{"option_key": "A", "option_text": "They make the program run faster by optimising code execution.", "option_explanation": "Incorrect. Exception handling is for error management, not performance optimisation."}, {"option_key": "B", "option_text": "They allow a program to continue running even after a critical crash.", "option_explanation": "Incorrect. They prevent the critical crash from happening in the first place, or allow a graceful exit, not continue after a crash."}, {"option_key": "C", "option_text": "They provide a way to handle unexpected events gracefully and prevent program crashes.", "option_explanation": "Correct! `try/catch/throw` blocks detect and handle errors, preventing crashes and allowing for graceful recovery or exits."}, {"option_key": "D", "option_text": "They convert all runtime errors into compile-time warnings.", "option_explanation": "Incorrect. Exceptions are runtime events; they are handled, not converted to compile-time warnings."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('6410632f-390a-4cc6-8a86-ebdc4aa42ec8', 'C', '[{"option_key": "A", "option_text": "It duplicates all nested objects recursively.", "option_explanation": "Incorrect. This describes a deep copy, which creates independent copies of all nested objects."}, {"option_key": "B", "option_text": "It creates an entirely new independent copy, including all referenced objects.", "option_explanation": "Incorrect. This describes a deep copy, ensuring full data independence."}, {"option_key": "C", "option_text": "It duplicates only the references to the original object''s nested objects, not the nested objects themselves.", "option_explanation": "Correct! A shallow copy creates a new object but its reference fields still point to the same nested objects as the original."}, {"option_key": "D", "option_text": "It is a copy method used only for primitive data types.", "option_explanation": "Incorrect. Copying primitives is straightforward (by value); shallow and deep copies apply to objects, especially those with references."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('7f2522d7-5624-4cc9-a650-fa3658c925b0', 'B', '[{"option_key": "A", "option_text": "It only copies primitive data fields, ignoring object references.", "option_explanation": "Incorrect. A deep copy specifically addresses object references."}, {"option_key": "B", "option_text": "It creates a new object and duplicates all referenced (nested) objects recursively.", "option_explanation": "Correct! A deep copy ensures that the new object and all its nested objects are completely independent instances."}, {"option_key": "C", "option_text": "It creates a new object that shares the same memory address as the original object.", "option_explanation": "Incorrect. Creating a new object implies a different memory address; sharing the same address is not a copy."}, {"option_key": "D", "option_text": "It is only used for objects that do not contain any other objects.", "option_explanation": "Incorrect. Deep copies are most beneficial when objects contain references to other objects."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('5de24cd6-0cc8-4243-bbf7-a8ce782489a2', 'B', '[{"option_key": "A", "option_text": "A deep copy, to ensure complete independence.", "option_explanation": "Incorrect. A deep copy would create a new, independent `List` of `Course` objects, not share the original."}, {"option_key": "B", "option_text": "A shallow copy, because it duplicates the reference to the `courseEnrollment` list.", "option_explanation": "Correct! A shallow copy will make a new `Student` object, but both the original and the new `Student` will reference the *same* `courseEnrollment` list."}, {"option_key": "C", "option_text": "Neither, as object copying is not possible with nested structures.", "option_explanation": "Incorrect. Both shallow and deep copying are specifically designed for objects, including those with nested structures."}, {"option_key": "D", "option_text": "Only a primitive copy would work here.", "option_explanation": "Incorrect. `courseEnrollment` is a reference to an object (`List`), not a primitive type, so primitive copying rules do not apply directly to it."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c02a0102-0ca0-47fc-bab7-624e8399194f', 'C', '[{"option_key": "A", "option_text": "To remove an object from memory.", "option_explanation": "Incorrect. This action is typically handled by garbage collection or destructors, not constructors."}, {"option_key": "B", "option_text": "To define the public methods an object can perform.", "option_explanation": "Incorrect. Public methods define behaviours, but not the initial setup of an object."}, {"option_key": "C", "option_text": "To set a new object to an initial, stable state.", "option_explanation": "Correct. Constructors are used to initialise essential attributes and ensure the object is ready for use."}, {"option_key": "D", "option_text": "To return a value after a specific calculation.", "option_explanation": "Incorrect. Constructors do not return values and their primary role is initialisation, not calculation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('aa9b7096-b66e-4333-a985-499c564b034f', 'C', '[{"option_key": "A", "option_text": "When a class is declared in a program file.", "option_explanation": "Incorrect. Declaring a class defines its structure, but does not create an object instance."}, {"option_key": "B", "option_text": "When an existing object''s method is called.", "option_explanation": "Incorrect. Calling a method executes a specific function of an already existing object."}, {"option_key": "C", "option_text": "When a new object is created using the `new` keyword.", "option_explanation": "Correct. Constructors are automatically run at the moment a new object instance is allocated and built."}, {"option_key": "D", "option_text": "When an object is no longer referenced and becomes eligible for garbage collection.", "option_explanation": "Incorrect. This refers to the end of an object''s lifecycle, not its creation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('f5ce9e9d-dbe5-41fc-8a8e-bc12474bb54f', 'C', '[{"option_key": "A", "option_text": "Simplifies the overall design of the system by reducing code duplication.", "option_explanation": "Incorrect. While it might reduce some duplication, the KC states it increases complexity."}, {"option_key": "B", "option_text": "Decreases the number of public methods required for a class.", "option_explanation": "Incorrect. The number of methods is not directly addressed as a consequence in this context."}, {"option_key": "C", "option_text": "Increases complexity and can cause design issues.", "option_explanation": "Correct. Multiple inheritance can introduce ambiguity and complicate the class hierarchy, leading to higher complexity and potential design problems."}, {"option_key": "D", "option_text": "Eliminates the need for constructors in subclasses.", "option_explanation": "Incorrect. Constructors are still necessary for object initialization regardless of inheritance type."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('02588968-66cb-4567-b248-ee915fc77758', 'C', '[{"option_key": "A", "option_text": "Inherit attributes and methods from a single parent class.", "option_explanation": "Incorrect. This describes single inheritance."}, {"option_key": "B", "option_text": "Be created without any explicit parent class.", "option_explanation": "Incorrect. This refers to a class with no declared superclass, not multiple inheritance."}, {"option_key": "C", "option_text": "Inherit from more than one parent class.", "option_explanation": "Correct. Multiple inheritance is the ability of a class to inherit characteristics and features from more than one superclass."}, {"option_key": "D", "option_text": "Implement multiple interfaces to define its behavior.", "option_explanation": "Incorrect. While related to combining features, this is a different mechanism often used as an alternative to multiple inheritance."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('4f0299ab-f1d6-4024-a818-6b0f07a1b57a', 'C', '[{"option_key": "A", "option_text": "It improves the runtime performance of the program.", "option_explanation": "This is incorrect. Constructor overloading primarily concerns object initialisation flexibility, not performance optimisation."}, {"option_key": "B", "option_text": "It allows a class to create objects of different data types.", "option_explanation": "This is incorrect. Constructor overloading allows creating different instances of the *same* class, each initialised differently, not different data types."}, {"option_key": "C", "option_text": "It enables flexible object creation and initialisation based on the available input data.", "option_explanation": "Correct! Constructor overloading provides various ways to construct an object, adapting to the specific data provided during instantiation."}, {"option_key": "D", "option_text": "It enforces strict data hiding for all class attributes.", "option_explanation": "This is incorrect. Data hiding is achieved through access modifiers (like ''private''), not directly through constructor overloading."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('0b543673-4122-4f09-9489-4f598e1863ce', 'D', '[{"option_key": "A", "option_text": "The return type of the constructor.", "option_explanation": "This is incorrect. Constructors do not have a return type, so the compiler cannot use it for selection."}, {"option_key": "B", "option_text": "The order in which the constructors are defined within the class.", "option_explanation": "This is incorrect. Constructor order in the code does not influence compiler selection; it''s based on the signature."}, {"option_key": "C", "option_text": "The access modifier (e.g., public, private) of the constructor.", "option_explanation": "This is incorrect. Access modifiers control visibility, not the compiler''s selection of an overloaded constructor."}, {"option_key": "D", "option_text": "The **distinct signature**, which includes the number and types of parameters.", "option_explanation": "Correct! The compiler uses the constructor''s signature (its name combined with the number and type of its parameters) to determine which overloaded constructor to invoke."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('72351141-4690-418a-ab49-5fc266bcde68', 'B', '[{"option_key": "A", "option_text": "Declare all of the interface''s methods as private.", "option_explanation": "This is incorrect. While methods can be private for internal use, implementing an interface requires public or protected concrete implementations of its abstract methods."}, {"option_key": "B", "option_text": "Provide concrete implementations for **all** of the interface''s abstract methods.", "option_explanation": "Correct! A concrete class must provide a concrete implementation for every abstract method defined in the interface to fulfill its contract."}, {"option_key": "C", "option_text": "Extend the interface to add new abstract methods.", "option_explanation": "This is incorrect. Classes implement interfaces, they do not extend them to add new methods. Extending applies to other interfaces or classes."}, {"option_key": "D", "option_text": "Inherit the interface''s attributes and default method implementations.", "option_explanation": "This is incorrect. Interfaces primarily define abstract methods and a contract for behavior, not attributes or default implementations that are directly inherited in the same way as from a class."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('de77a950-8e84-457d-b7b8-0443e6ebefe7', 'B', '[{"option_key": "A", "option_text": "It allows the class to inherit data from multiple parent classes.", "option_explanation": "This is incorrect. Interfaces do not allow for multiple *implementation* inheritance of data or methods, focusing instead on defining a behavioral contract."}, {"option_key": "B", "option_text": "It ensures the class provides specific functionalities, making it compatible with other components.", "option_explanation": "Correct! Implementing an interface guarantees that a class provides a defined set of functionalities, which allows it to seamlessly interact with any component designed to use that interface."}, {"option_key": "C", "option_text": "It automatically generates all necessary method implementations for the class.", "option_explanation": "This is incorrect. The class itself is responsible for providing the concrete implementations for the interface''s abstract methods."}, {"option_key": "D", "option_text": "It hides the internal implementation details of the class from external users.", "option_explanation": "This is incorrect. Data hiding is achieved through access modifiers (like ''private''), not directly through the act of implementing an interface, though interfaces contribute to overall good design."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('a92bd2e9-498b-4bcb-8c47-7a1acbe17a3c', 'A', '[{"option_key": "A", "option_text": "The class will become an abstract class itself, and cannot be instantiated.", "option_explanation": "Correct! If a class doesn''t implement all methods of an interface it claims to implement, it must be declared abstract, preventing direct instantiation."}, {"option_key": "B", "option_text": "The missing method will be automatically generated with a default empty implementation.", "option_explanation": "This is incorrect. Java (and similar languages) do not automatically generate empty implementations for abstract interface methods; explicit implementation is required."}, {"option_key": "C", "option_text": "The program will compile, but a runtime error will occur when the missing method is called.", "option_explanation": "This is incorrect. The compiler will detect the missing implementation at compile time, preventing the program from running."}, {"option_key": "D", "option_text": "The interface will be ignored by the compiler for that specific class.", "option_explanation": "This is incorrect. The compiler strictly enforces interface contracts, ensuring all abstract methods are implemented or the class is marked abstract."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('122ce3a7-5108-4093-a2ce-98b0d92a3064', 'C', '[{"option_key": "A", "option_text": "An attribute shared by all objects of a class.", "option_explanation": "This describes a class-scoped attribute."}, {"option_key": "B", "option_text": "An attribute unique to each instance of a class.", "option_explanation": "This describes an object-scoped attribute."}, {"option_key": "C", "option_text": "An attribute declared within a method, existing only during that method''s execution.", "option_explanation": "Local scope applies to variables declared inside a method or code block, limiting their existence to that block."}, {"option_key": "D", "option_text": "An attribute that persists even after the program terminates.", "option_explanation": "This describes persistence, not scope."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('fa37af48-c661-4f27-a98b-2418bfe893b3', 'C', '[{"option_key": "A", "option_text": "It is shared among all methods in the program.", "option_explanation": "This suggests a global scope, which is not typical in well-designed OOP."}, {"option_key": "B", "option_text": "It is accessible only within the constructor of the class.", "option_explanation": "Object-scoped attributes are accessible by all methods within their specific object instance."}, {"option_key": "C", "option_text": "Each object instance has its own unique copy of the attribute.", "option_explanation": "Object-scoped attributes define the state unique to each object instantiated from a class."}, {"option_key": "D", "option_text": "It is automatically set to null when the program starts.", "option_explanation": "Default initialization varies by language and type, but this is not a defining characteristic of object scope."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c87a7c57-f62e-488a-89d0-3a2a066d9f4b', 'C', '[{"option_key": "A", "option_text": "It is declared within a method and is temporary.", "option_explanation": "This describes local scope."}, {"option_key": "B", "option_text": "Every object created from the class gets its own copy of the attribute.", "option_explanation": "This describes object scope."}, {"option_key": "C", "option_text": "It is shared by all instances of the class, with only one copy existing in memory.", "option_explanation": "Class-scoped attributes, declared with `static`, provide a single shared copy for all objects of that class."}, {"option_key": "D", "option_text": "It can only be accessed by private methods within the class.", "option_explanation": "Access modifiers (private, public) determine visibility, not whether an attribute is class-scoped."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('b440b7de-c36f-46ce-ba9b-fc9e60558621', 'B', '[{"option_key": "A", "option_text": "To create new operators not natively supported by the language.", "option_explanation": "Incorrect. Operator overloading redefines the meaning of *existing* standard operators for custom data types, rather than creating entirely new ones."}, {"option_key": "B", "option_text": "To allow standard operators to have special meanings for custom data types or objects.", "option_explanation": "Correct! This allows developers to redefine the behaviour of operators like `+` or `-` for their own classes, providing intuitive syntax."}, {"option_key": "C", "option_text": "To replace existing operators with custom method calls.", "option_explanation": "Incorrect. While it changes the operator''s underlying action, it doesn''t replace the operator symbol with a method call in the code itself."}, {"option_key": "D", "option_text": "To combine multiple operators into a single, more complex operator.", "option_explanation": "Incorrect. Operator overloading focuses on redefining the function of a single operator for specific data types."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('69232c5a-00f6-4275-9798-19c5de2de367', 'C', '[{"option_key": "A", "option_text": "Redefining the `+` operator to perform subtraction for two integer variables.", "option_explanation": "Incorrect. This use would be confusing and counter-intuitive, violating the principle of judicious use."}, {"option_key": "B", "option_text": "Using the `*` (multiplication) operator to compare two string objects for equality.", "option_explanation": "Incorrect. Multiplication has no intuitive link to string comparison, making this a poor use of overloading."}, {"option_key": "C", "option_text": "Implementing the `+` operator to concatenate two `String` objects.", "option_explanation": "Correct! This is a widely accepted and intuitive example, as `+` naturally implies joining when used with strings."}, {"option_key": "D", "option_text": "Overloading the `/` (division) operator to calculate the average of numbers in a list.", "option_explanation": "Incorrect. While related to numbers, division is not intuitively linked to finding an average, which is a more complex operation."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('19c26b27-0805-4d79-8a3b-e4693d07f074', 'C', '[{"option_key": "A", "option_text": "`public`", "option_explanation": "Incorrect. `public` is an access modifier, not part of the method signature."}, {"option_key": "B", "option_text": "`double calculateArea`", "option_explanation": "Incorrect. This includes the return type and method name but omits the parameter list, which is crucial for the signature."}, {"option_key": "C", "option_text": "`calculateArea(double length, double width)`", "option_explanation": "Correct. The method signature consists of the method''s name (`calculateArea`) and its parameter list (`double length, double width`)."}, {"option_key": "D", "option_text": "`double length, double width`", "option_explanation": "Incorrect. These are only the parameters, not the full method signature."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('0f7f5356-ab29-463a-ac1c-d557f77fd1ea', 'B', '[{"option_key": "A", "option_text": "The method signature defines the internal logic, while the method body defines how other objects interact with it.", "option_explanation": "Incorrect. This reverses the roles of signature and body."}, {"option_key": "B", "option_text": "The method signature describes how to invoke the method and its expected inputs/outputs, while the method body contains the actual logic that performs the operation.", "option_explanation": "Correct. The signature is the public contract, and the body is the hidden internal work."}, {"option_key": "C", "option_text": "Both the method signature and the method body are part of the hidden implementation details.", "option_explanation": "Incorrect. The method signature is typically part of the public interface, defining how other code interacts with it."}, {"option_key": "D", "option_text": "The method signature is relevant only for abstract methods, whereas the method body is for concrete methods.", "option_explanation": "Incorrect. Both abstract and concrete methods have signatures. All concrete methods have a body, while abstract methods do not provide one."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('63165c20-1c2d-478d-83b6-225e7d4964a6', 'A', '[{"option_key": "A", "option_text": "`processData(String data)`", "option_explanation": "Correct. Public methods like `processData` define the contract for how other objects interact with the class."}, {"option_key": "B", "option_text": "`logProcessing(String data)`", "option_explanation": "Incorrect. Methods declared as private are part of the internal implementation and are not directly accessible by other objects."}, {"option_key": "C", "option_text": "`// internal logging logic`", "option_explanation": "Incorrect. This is a comment describing part of the implementation, not an interface element itself."}, {"option_key": "D", "option_text": "The entire `DataProcessor` class", "option_explanation": "Incorrect. The entire class encompasses both interface and implementation; only specific public elements form the interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('5207e561-bc10-4a2f-af1f-07c0273ce717', 'B', '[{"option_key": "A", "option_text": "Create a separate class for each payment gateway (e.g., `PayPalGateway`, `StripeGateway`) and directly instantiate the required gateway within the order processing logic.", "option_explanation": "Incorrect. This approach leads to tight coupling because the order processing logic would need to change every time a new payment gateway is added or an existing one is modified."}, {"option_key": "B", "option_text": "Define a `PaymentGateway` interface with methods like `processPayment()` and `refund()`, and have specific gateway classes implement this interface. The order processing logic then interacts solely with the `PaymentGateway` interface.", "option_explanation": "Correct. This approach decouples the order processing logic from specific payment gateway implementations, allowing for easy addition or modification of gateways without affecting the core logic."}, {"option_key": "C", "option_text": "Develop a single `AllInOnePaymentGateway` class with many conditional statements to handle the unique logic for each payment provider.", "option_explanation": "Incorrect. This creates a highly rigid and complex class that is difficult to maintain and extend, violating loose coupling."}, {"option_key": "D", "option_text": "Use inheritance, with `PaymentGateway` as a base class and each specific gateway (`PayPalGateway`, `StripeGateway`) extending it, directly overriding all base class methods.", "option_explanation": "Incorrect. While inheritance can be used, simply extending a base class directly can still lead to some coupling, especially if the base class contains implementation details that might need to change or if the hierarchy becomes too deep. An interface offers stronger decoupling for behavioural contracts."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('520bbd96-53fc-4500-981d-651687e36258', 'B', '[{"option_key": "A", "option_text": "It means the `Apple` and `Carrot` classes share the same code for their `eat()` method.", "option_explanation": "Incorrect. While they share the method signature, their implementations of `eat()` will be specific to each class."}, {"option_key": "B", "option_text": "It allows a single method to process any `Edible` object, reducing the need for separate code paths for `Apple` and `Carrot`.", "option_explanation": "Correct. This reusability comes from writing generic code that interacts with the interface, not the concrete classes directly."}, {"option_key": "C", "option_text": "It implies that `Apple` and `Carrot` are part of the same inheritance hierarchy.", "option_explanation": "Incorrect. Classes implementing the same interface do not necessarily belong to the same inheritance hierarchy."}, {"option_key": "D", "option_text": "It forces all future food items to be either an `Apple` or a `Carrot`.", "option_explanation": "Incorrect. It allows any new class that represents an edible item to implement the interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('69f519f6-19ee-4c97-883a-f8416d75ad2c', 'B', '[{"option_key": "A", "option_text": "To define the actions an object can perform.", "option_explanation": "Incorrect. This describes the role of methods or behaviors."}, {"option_key": "B", "option_text": "To store the state or characteristics of an object.", "option_explanation": "Correct! Attributes are data members that define the state, characteristics, or properties of an object."}, {"option_key": "C", "option_text": "To enable communication between different objects.", "option_explanation": "Incorrect. Communication between objects is typically handled through messages, which involve methods."}, {"option_key": "D", "option_text": "To create new instances of a class.", "option_explanation": "Incorrect. Objects are created using constructors and the `new` keyword."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('4dcd8570-4b45-4806-93e6-5f5123c57455', 'B', '[{"option_key": "A", "option_text": "The internal steps and logic performed by the method.", "option_explanation": "Incorrect. This describes the method''s implementation, not its signature or interface."}, {"option_key": "B", "option_text": "The method''s name, its parameters, and its return type.", "option_explanation": "Correct. The method signature defines how the method is called, including its name, the types and order of its parameters, and its return type."}, {"option_key": "C", "option_text": "The access modifier (e.g., `public`, `private`) and any comments.", "option_explanation": "Incorrect. While access modifiers are part of the method declaration, they are not strictly part of the method''s unique signature for overloading purposes, and comments are documentation."}, {"option_key": "D", "option_text": "The memory allocated for the method''s execution.", "option_explanation": "Incorrect. This relates to runtime execution, not the definition of the method''s interface."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('c529bc42-8bc1-462a-b08a-a9eb0d2fe311', 'C', '[{"option_key": "A", "option_text": "It creates a single copy of the attribute shared by all objects of the class.", "option_explanation": "Incorrect. This describes a `static` attribute."}, {"option_key": "B", "option_text": "It allows direct access to the attribute from any other class in the program.", "option_explanation": "Incorrect. This would be true for a `public` attribute."}, {"option_key": "C", "option_text": "It ensures the attribute can only be accessed or modified from within its own class.", "option_explanation": "Correct! Declaring an attribute as `private` restricts its direct access to only the methods within its own class, promoting data hiding and a minimal interface."}, {"option_key": "D", "option_text": "It makes the attribute accessible only to subclasses.", "option_explanation": "Incorrect. This describes the `protected` access modifier."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('afc2df53-9728-4108-a3b6-b164044ef33f', 'B', '[{"option_key": "A", "option_text": "To provide a complete implementation of a class with all its behaviours.", "option_explanation": "Interfaces define method signatures but do not provide their implementation details."}, {"option_key": "B", "option_text": "To act as a **contract** specifying a set of abstract methods that implementing classes must define.", "option_explanation": "Correct! Interfaces establish a contract for behaviour, outlining methods that must be implemented by any class that ''signs'' the contract."}, {"option_key": "C", "option_text": "To enable direct instantiation of objects with shared, static attributes.", "option_explanation": "Interfaces cannot be directly instantiated to create objects."}, {"option_key": "D", "option_text": "To restrict access to internal data and methods, completely hiding them from external use.", "option_explanation": "This describes data hiding or encapsulation, while interfaces define public contracts."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('9152f72e-7bb5-4ef0-93f1-dbdaca4e5f2e', 'C', '[{"option_key": "A", "option_text": "A `Car` class inheriting attributes like `color` and `make` from a `Vehicle` superclass.", "option_explanation": "Incorrect. This describes inheritance, not polymorphism through an interface."}, {"option_key": "B", "option_text": "A single `Calculator` object performing addition, subtraction, and multiplication.", "option_explanation": "Incorrect. This demonstrates method overloading or multiple responsibilities within one object, not interface-based polymorphism."}, {"option_key": "C", "option_text": "A method that accepts an `Animal` interface, and correctly calls `makeSound()` on both a `Dog` object (which barks) and a `Cat` object (which meows).", "option_explanation": "Correct. This exemplifies polymorphism, where generic code operates on different concrete types via a common interface, invoking specific implementations."}, {"option_key": "D", "option_text": "Storing different types of data (integers, strings) in a single array.", "option_explanation": "Incorrect. This describes data structures, not the behavioral flexibility provided by interface polymorphism."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('0d6e8529-998d-40dd-b048-fdb7c8685efa', 'B', '[{"option_key": "A", "option_text": "To strictly enforce single inheritance for all classes.", "option_explanation": "Incorrect. Interfaces are distinct from inheritance hierarchies and are often used to overcome single inheritance limitations for behavior."}, {"option_key": "B", "option_text": "To define a common contract for behavior that diverse classes can implement, allowing them to be treated interchangeably.", "option_explanation": "Correct. Interfaces provide a common type, enabling objects of different classes to share a behavioural contract and be used polymorphically."}, {"option_key": "C", "option_text": "To prevent classes from having any methods or attributes.", "option_explanation": "Incorrect. Interfaces define method signatures, and implementing classes provide the actual methods and can have attributes."}, {"option_key": "D", "option_text": "To tightly couple concrete classes together, making them interdependent.", "option_explanation": "Incorrect. Interfaces promote loose coupling by allowing code to depend on the interface rather than concrete implementations."}]');
INSERT INTO public.multiple_choice_questions (question_id, correct_option_key, options) VALUES ('fe78ea63-8eb3-496b-9931-90430f1a864a', 'B', '[{"option_key": "A", "option_text": "```java\nclass Printable {\n    public void printDocument();\n}\n```", "option_explanation": "This uses the `class` keyword and methods in a regular class require a body or the class must be abstract."}, {"option_key": "B", "option_text": "```java\ninterface Printable {\n    public abstract void printDocument();\n}\n```", "option_explanation": "Correct! This uses the `interface` keyword, and methods within an interface are implicitly `public` and `abstract`."}, {"option_key": "C", "option_text": "```java\npublic interface Printable {\n    void printDocument() { /* implementation */ }\n}\n```", "option_explanation": "Interfaces cannot provide implementation details for their methods."}, {"option_key": "D", "option_text": "```java\nabstract class Printable {\n    abstract void printDocument();\n}\n```", "option_explanation": "This defines an `abstract class`, not an `interface`."}]');


--
-- Data for Name: question_kc_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '803a4f07-4b9b-4428-855c-56931180ac44', '1e9e28c9-9590-44bc-8971-2a29dbd2e4aa');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ae3025ca-1a56-4f7a-975c-c19a839427bd', '6157ccc8-f53d-4edf-9fab-db0e9c92c73f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ae3025ca-1a56-4f7a-975c-c19a839427bd', 'eca7d620-d9fe-4e39-b83b-4e2f86a9126a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ae3025ca-1a56-4f7a-975c-c19a839427bd', '5dbc1405-c207-4ffe-ad5c-71633ad29aa9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ae3025ca-1a56-4f7a-975c-c19a839427bd', '9593327a-46a8-4b5c-8f3f-c74f415152c9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '8d3c8c63-7c2a-4ae2-b052-a14f01bdcfd1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', 'fde1c387-3597-4a5c-8673-871ebb4ad75b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '37391e56-d241-41a5-a7dc-0337efd3b083');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '58e808a3-5068-4574-8363-08b530c39c85');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '1aaabfab-be55-4b3d-b54e-0aff1e187e69');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cbfaa6b7-4726-4c1a-be60-7a4dcfd3a79c', '20fa95aa-aa2a-4af1-b70c-3edb8c95c546');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', '6f6cc360-0752-4cdd-ac2f-cbe201f5c9db');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', '9eacb988-f58b-494a-ab8f-c5e336824eb0');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', '665f4941-f8bc-4a30-9e12-a10bfbf95f71');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', '61de4ab3-c8bf-4c2e-a44f-5aaf389c9dcb');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'be10e514-f9ec-46bc-b4ef-18fad43eea8e');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1d9a400-1faa-4a6b-be2a-0b55b3f219e6', 'aeb0e446-b9bc-4b30-8c4d-613ebc224f6d');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9fbe5a80-4649-445d-8bf2-a4c4795d8571', '034177ba-c716-4b8b-9aa9-701cc0ce112b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'feec1a5d-9095-482d-861a-a698b8b0827c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f947c4d8-c88b-4522-acd2-59d9cf755d48', '642c4a8d-7295-4822-84cd-6c589067b053');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'a5ac4e35-eac4-4e71-bee8-4eddd314b4ce');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f947c4d8-c88b-4522-acd2-59d9cf755d48', '44504bb0-41e4-4434-a968-5714eb084a44');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f947c4d8-c88b-4522-acd2-59d9cf755d48', 'ffd422dc-dbc7-4a41-a002-91aa03e70dd9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '0003e2a5-2711-49ca-95ed-a361b61bc418');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '73728c43-0dbd-4de1-8e21-65a519874c83');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '3ade7bbc-8cbc-4e63-8938-1f3ceb75f941');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '8d256539-243c-47a4-a5cf-eed9f5eacfd3');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '160dfb93-0f61-4fe2-bfd9-cc5e6e8f7fcc', '35c97850-9c82-42fa-917f-c8ee852c54c4');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9e116c2d-907b-4027-abf4-1c427f5b9055', '07a34361-54aa-456e-8e3e-f33ab7e54baf');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9e116c2d-907b-4027-abf4-1c427f5b9055', '02785fc6-3f61-4ffd-8b2b-0c55d72a20e0');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9e116c2d-907b-4027-abf4-1c427f5b9055', 'f7fd4704-fd08-412d-b755-f9462210bfac');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9e116c2d-907b-4027-abf4-1c427f5b9055', '32c9b366-417a-4b4c-b717-ecdfde1e87d3');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9e116c2d-907b-4027-abf4-1c427f5b9055', 'ea50d206-0377-4a0d-9874-64993cc01d6f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9e116c2d-907b-4027-abf4-1c427f5b9055', '7f9befc5-45dc-4f2b-9a6b-9de14edae151');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'aba7461f-882c-49dc-8007-8e14801cb4df', 'fe1cf1ab-2d94-4ff9-b4b4-451a50dc2024');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'aba7461f-882c-49dc-8007-8e14801cb4df', '9f0cdb7c-0837-479d-949e-3e68500974b1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'aba7461f-882c-49dc-8007-8e14801cb4df', 'c94e5bb0-f813-4bfb-8bda-6fcadb1e1f0f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'aba7461f-882c-49dc-8007-8e14801cb4df', 'c1504e54-0457-462b-97ca-5d6f3a42f676');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'aba7461f-882c-49dc-8007-8e14801cb4df', '79f145b2-3430-443d-a11b-ed2522d1a3df');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'aba7461f-882c-49dc-8007-8e14801cb4df', 'dcb1de41-8588-483d-9e02-77715c9a95c5');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '8b39feab-7d75-4c8d-b1cd-177a6f23ecdf');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', 'e57fa057-585c-4abb-95ec-320343fb6cf5');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', 'a58e3c86-b89e-4c45-b5d1-ffd972671849');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '985cc2aa-9595-4ba0-a70a-2451b5ddc8a6');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', 'feb4a19d-55b1-4e3d-8614-17cc940d2f67');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ee798b06-be6a-49f8-99ae-9a6fa3b06ee8', '05451828-5f5f-4066-b83b-f22af4a617f7');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', '34d82057-a293-4f9a-86ef-df067ca2909e');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', 'ff5a4a81-fdab-479b-9424-e3e9b5801553');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', 'fb960709-a4bd-41c0-8910-608b719b65af');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', 'e5c0f586-2eff-4f41-abdc-09c9b61e689e');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', '2705f7df-f1f1-4c99-89a9-b97639d0cc30');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', 'c2204b5d-e5dd-4d7c-9751-6f2a071f8200');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f0151e0a-4d88-4160-b9df-3d8eff23d352', 'cde20b6e-eea6-4e55-b944-1df6fadb2528');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '7805bbf6-6a55-4dd9-abc3-32182da43799');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1889697c-ddf5-4397-b94f-ecad3a5e71dd', 'edbab82e-1826-4efb-b07f-f7d684d9bc50');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '0d5f0624-1d15-4004-87e9-3d7743f90e8c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1889697c-ddf5-4397-b94f-ecad3a5e71dd', 'eb79b12f-a85f-475f-816e-bdde79fe19f4');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '515d04cd-f8ec-4910-ac7f-721d95562b65');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1889697c-ddf5-4397-b94f-ecad3a5e71dd', '973ab281-fd9b-4760-a64c-f49a9b59b314');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'e1ed95f4-7a5c-4fb1-9195-73ee1a7fd8a5');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'd1c3ed01-5297-4f3e-8a60-5400867c65cd');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', '46ab0646-3b78-490d-81c5-9435a5861a90');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', 'be8aa773-2d03-42a5-8ad3-ec04bf5f022c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', '35334e96-d0bb-4935-8f22-e968575056b4');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9bb31f2f-5dfb-49dd-8120-b0e28e51d23d', '57b54c7a-c7ef-47c2-8bf2-aa351abbf02c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '2ed95544-8955-4b79-abda-d09f8d9499d1', 'c027d03c-5c65-47f6-9a13-a418e6b792b6');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '2ed95544-8955-4b79-abda-d09f8d9499d1', '9f2604be-124c-451d-8d5b-983f80a98751');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '2ed95544-8955-4b79-abda-d09f8d9499d1', 'bfc5d85e-b231-4037-a1f6-9142e7fb50bd');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '2ed95544-8955-4b79-abda-d09f8d9499d1', 'ad35ba58-7918-4923-a4cf-9b7e963d1961');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '2ed95544-8955-4b79-abda-d09f8d9499d1', 'eacbbb4f-993c-4307-8144-552cfdfaeff9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '2ed95544-8955-4b79-abda-d09f8d9499d1', 'a117a00a-194f-493c-90dd-036707b26568');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f301d039-f264-4188-b368-39bad0e05c1c', 'ca327a31-5a12-45be-9974-814191640a2b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f301d039-f264-4188-b368-39bad0e05c1c', 'c4715bd3-517b-425d-9bcf-f167262d5277');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f301d039-f264-4188-b368-39bad0e05c1c', 'eafc849b-8947-42f2-a389-1af9984448c2');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f301d039-f264-4188-b368-39bad0e05c1c', '619f0ba2-97b9-413d-9e97-d1f2c3d273ca');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f301d039-f264-4188-b368-39bad0e05c1c', '98d159c6-bbca-4f86-ad25-74d43e7deb31');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f301d039-f264-4188-b368-39bad0e05c1c', '65c484a7-d54d-4cf1-9d19-9a63290029ea');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', '80e0e991-1c4f-4e10-8998-2c913bda0173');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', '3633fbab-bcd9-4950-8d15-a33fc79d27f3');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', '8aa229f7-ddbd-48c5-98df-b71a16f1790d');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'b1adc3b9-38a9-4028-aad6-251108592819');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '0cfa2783-f0cf-4082-aa1c-1d70e07fd96d', 'f50a4a8f-aa6a-41ec-b276-db271e9fa419');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', '88d37ef1-2aa8-462c-91d7-58e1dbb977b9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', 'f3e2cd90-912c-44c3-998a-e6b3bf38511d');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', 'f7c8818a-70da-461a-8cd6-7bcd9ec592f2');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', 'd068acdf-93d0-4b60-aa34-acad18893d24');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7517905d-9f0b-4eeb-8e80-2718ebfb5a72', '967d8f4c-60e0-40ef-9795-217aee6dbc6a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7bd074f2-04d0-462c-8d0d-a53ac985e077', 'a22216a5-7c02-4dbd-b627-99057f2b9299');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7bd074f2-04d0-462c-8d0d-a53ac985e077', '8946a048-2cb1-45a2-8cc6-14dd000710d1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7bd074f2-04d0-462c-8d0d-a53ac985e077', '382dbf51-54df-428c-a443-dc3f00368652');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7bd074f2-04d0-462c-8d0d-a53ac985e077', 'c2d99813-7881-4e6d-98c1-ed22d048f251');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '803a4f07-4b9b-4428-855c-56931180ac44', 'e84854d9-db4b-40ef-ba4b-478218616486');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '803a4f07-4b9b-4428-855c-56931180ac44', '2eaab065-6616-46f2-9933-bc07bbf03945');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '803a4f07-4b9b-4428-855c-56931180ac44', '2bfc0ea9-d292-4009-87af-67661206e9f5');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9fbe5a80-4649-445d-8bf2-a4c4795d8571', 'd92a884e-c219-4d88-a84f-8681d8942417');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9fbe5a80-4649-445d-8bf2-a4c4795d8571', 'fa909bd7-503d-4a32-80a3-0dfabb66e28c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9fbe5a80-4649-445d-8bf2-a4c4795d8571', '869c489f-10db-42ae-9162-e3f850680d42');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', '25d4205b-69da-4b39-9abb-adfc2dc6b4a0');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', 'b20e6ce6-92d9-48be-aa48-f3b39ffa0705');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', '55ada1c2-5737-4948-a950-37aa8531ca4b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '7a3b6aa3-01d2-4374-896e-33fdb9b3d428', '67f2465f-458e-448b-8de8-a90c8c09884b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4d11f382-1287-4e52-b80f-d2dc1e655725', 'dae4ec50-4cec-4d5f-8510-05d28dd1eb5e');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4d11f382-1287-4e52-b80f-d2dc1e655725', '8738dab3-6b5a-436a-ab21-c01ff9d152a4');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4d11f382-1287-4e52-b80f-d2dc1e655725', '4a7a5ce9-66ed-46c0-a816-e8ae9a6ea7ea');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4d11f382-1287-4e52-b80f-d2dc1e655725', '894d1b82-5bdb-41b6-9f4b-d151ed535732');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4d11f382-1287-4e52-b80f-d2dc1e655725', '76fbb78a-6ad3-4901-b3b6-47992175ff8b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1db3b49c-dfef-4855-94df-45b59047fa25', '69ac3d23-f357-46eb-8f3d-bf9a2fd96a0b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1db3b49c-dfef-4855-94df-45b59047fa25', 'b05e73a0-963f-49ea-9a47-caa551dfc530');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1db3b49c-dfef-4855-94df-45b59047fa25', '98243b86-e221-473a-98c5-c00ae328fe1b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1db3b49c-dfef-4855-94df-45b59047fa25', 'e61c5e03-8ab6-4059-8d2c-bdfcc3dcc677');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'a3878dc5-979e-47f1-b344-e8fa69845ef6', 'f61ab599-ae39-4ee8-923e-62a23468e185');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'a3878dc5-979e-47f1-b344-e8fa69845ef6', '232827d8-1365-4cf3-9f4e-8bb317b88d2f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'a3878dc5-979e-47f1-b344-e8fa69845ef6', '5fe02d93-b135-4d8e-9c84-f01df5cda967');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'a3878dc5-979e-47f1-b344-e8fa69845ef6', 'e99fa713-6d2d-49b8-b4d3-f2cd7b4ab625');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'a3878dc5-979e-47f1-b344-e8fa69845ef6', '6819a748-cf5b-43b3-826a-97d50a102445');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'a3878dc5-979e-47f1-b344-e8fa69845ef6', '8e07dd6d-3caa-451d-ba20-63ce996bdeea');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '36e59beb-3737-4a17-b8b0-d240ff8fd674', '8b0ed57a-7211-4c31-b3ec-d5e15c44f356');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '36e59beb-3737-4a17-b8b0-d240ff8fd674', 'c5349080-b322-4f51-b497-dcb1738dd14a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '36e59beb-3737-4a17-b8b0-d240ff8fd674', '5a588477-68c4-4f97-b636-85daa7ce6e62');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '36e59beb-3737-4a17-b8b0-d240ff8fd674', '8c98acc5-84cc-49d8-912d-ff555fe516ca');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c83bb940-8d84-4bc2-ae69-0c8757207c77', 'ce667025-d1fe-4ad1-bc40-1171d0560aa8');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '231e02a7-1000-4323-a5c7-67cd2575e870');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ea329450-6108-4b0b-88fb-df8609932bde', '730403b9-5558-4ed7-9d18-5d9a4cabc6b6');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'c8bee84d-ebc6-4abb-8b4f-f38a2d2eb398');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c83bb940-8d84-4bc2-ae69-0c8757207c77', 'b6fce91c-fb87-4d57-856d-5f57704256a2');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '251883e1-d851-447c-b986-be4dcab5dcc5');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '879a304b-b2d3-46c6-982e-e75ef475d4e2', '551de974-c017-4509-b750-9ca4486c87a1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c83bb940-8d84-4bc2-ae69-0c8757207c77', '788b54c3-e1cf-4883-b691-3783e5aafc47');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c83bb940-8d84-4bc2-ae69-0c8757207c77', '44cd4a6c-057f-46f9-8b4c-485a3f90977c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '623cccb4-d5b4-4c07-bbb3-630c195882cd');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '879a304b-b2d3-46c6-982e-e75ef475d4e2', '8e02cc12-78ee-4cea-ac09-849fecd1bb0d');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ea329450-6108-4b0b-88fb-df8609932bde', 'bd4f3fc0-16c4-4c85-b70d-f2a8438fb86c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ea329450-6108-4b0b-88fb-df8609932bde', '754062c6-e890-40c2-8797-da3981b03891');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', '055064e7-0ec4-47ef-843d-52d3caa042d9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'c854590d-1141-42be-90b8-47a91d59afe5');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', '08b82dca-6f46-4031-ae2d-cdd78ff09208');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'cc18e0f4-0ab0-4bae-8d93-4fe47d4feca6', '5ea915ba-e221-46be-9b49-8308b5474914');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'edd8fd58-924f-4435-8f3b-d17bfe66ef90');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', '470e26d0-b23a-4e17-8832-e3fe831f1101');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '879a304b-b2d3-46c6-982e-e75ef475d4e2', 'a324b912-609f-41a2-b23b-bf4f57b41f6b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ea329450-6108-4b0b-88fb-df8609932bde', '309ea252-d17c-403f-92d2-c2463b94ef45');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '256ae5b0-5754-4eb5-8bb7-b030390fb5f6', 'c6da3044-b2e9-4480-87f5-c150f9545467');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', '0b3be419-77cf-4989-af13-efa2987a79f9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', '3db7efa0-4a2a-48bb-8db1-a5cef534a60c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', '42d721b7-52d0-4bdd-a356-d5a0218cc5cd');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '4c0b2a6f-247c-4b94-a1c3-e7abef2a1234', 'fcd44ed1-4891-4261-a81b-2b15e73b9cd1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '70e7ec3d-fd9c-40db-b124-8bb514e395c6');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', 'd727fb5a-5aa3-447a-a256-45f62f356f59');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '29ffb430-c86d-4925-9382-1f7cc5f5663d');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '1cbef223-4c02-4664-98cf-90fe1489efd9');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '5312c739-2cae-4c6a-978f-3634c3105920');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'e293e2c6-99a8-49c9-97d2-fd67086cdef3', '5054929b-6006-4469-851a-83ed99b73024');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'd5c9571a-9707-4d05-8367-5e6bb8ec7719');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '447c13bc-d60e-4032-8d0c-af9837b04ab2', '3b35054e-7697-46f7-9301-ac5691b66c3a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '447c13bc-d60e-4032-8d0c-af9837b04ab2', '123297ed-89d4-43dd-affc-3abecee73495');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '447c13bc-d60e-4032-8d0c-af9837b04ab2', 'c4604a3f-2f58-4b67-9861-fa794e41648e');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f8e293fe-8bdf-44cc-9a73-412520a80e62', '641d22e9-e90b-45b9-9d56-6a9f070ff803');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f8e293fe-8bdf-44cc-9a73-412520a80e62', '5988473a-c9b8-4bcc-bd43-e63330582112');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f8e293fe-8bdf-44cc-9a73-412520a80e62', '7b000bc3-6a3a-4fe4-80d1-96340d071514');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f8e293fe-8bdf-44cc-9a73-412520a80e62', '07966f05-f013-4dbd-9fe8-b41160502f18');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '148f7ad4-89e4-4454-8acb-7041c7876824', 'db7a1347-ee38-4496-bc72-e4b2ade0802a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '148f7ad4-89e4-4454-8acb-7041c7876824', '4a5fa5c3-abf0-4c04-817f-232c1d3783c0');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '148f7ad4-89e4-4454-8acb-7041c7876824', '991d1199-22ac-4eae-8e19-ae8239fd40c6');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '148f7ad4-89e4-4454-8acb-7041c7876824', 'bfd15738-1c67-4904-af32-5847677740ee');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', 'c8a305aa-31e5-491e-a959-134250d5b766');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', '0f221384-6792-4873-a41e-bcbfcbcc3bab');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', 'f7459686-8887-423d-ae3d-a62fda75aed3');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '22ff0a1d-bfb4-4d88-862a-29ec02a744fa', '50415c83-29fd-4fcf-b5b7-0b79a5e981f1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1323bbe7-116c-4fb1-b059-b8a07e0916ca', '8fd4e29c-a7ab-49a4-a824-73388a5437e1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1323bbe7-116c-4fb1-b059-b8a07e0916ca', '084f878a-7169-4b31-b2e6-01cef6130a4c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1323bbe7-116c-4fb1-b059-b8a07e0916ca', '748d25c9-32a2-4d0e-80d3-c0ecd4f2bea1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1323bbe7-116c-4fb1-b059-b8a07e0916ca', '8be897a9-f1af-4b6a-a2d5-a89d3600fa12');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1323bbe7-116c-4fb1-b059-b8a07e0916ca', 'b4483529-0e67-44cb-aaf4-6188838ffc87');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '96207b35-90f2-4236-9886-7760d38e42ad', '1ba54d58-cac1-4184-b94b-c06dc6b28210');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '96207b35-90f2-4236-9886-7760d38e42ad', 'a8aa6b6b-3b3a-402e-8e43-3e3442a4726f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '96207b35-90f2-4236-9886-7760d38e42ad', '833a3045-a4d6-4c02-8f2e-0f6c26dae31a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '96207b35-90f2-4236-9886-7760d38e42ad', '35a0b16b-7fad-4c90-ba92-8bf155a529fc');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '96207b35-90f2-4236-9886-7760d38e42ad', 'c15717c4-7451-4bca-84e4-254ecf57f785');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '96207b35-90f2-4236-9886-7760d38e42ad', 'd1548300-b2e3-4ebd-81b6-90b5fa8a1bd1');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '97a48d3a-8282-4216-a58b-cbf75d3c7023', 'e030ecb9-d2ae-43d6-8243-f6730a1aed24');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '97a48d3a-8282-4216-a58b-cbf75d3c7023', 'bfdd8e8f-85c3-488b-81b9-8615e8433fd2');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '97a48d3a-8282-4216-a58b-cbf75d3c7023', '01f03e7f-da6e-4fa9-8159-a1fea5aaedf7');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '97a48d3a-8282-4216-a58b-cbf75d3c7023', '744685e6-7137-4b21-863d-11ae6a0a0c9b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '97a48d3a-8282-4216-a58b-cbf75d3c7023', '57707cb3-aee9-40a9-92f7-da8262a2b142');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ce845442-0c3d-4de6-bbe6-765445fbfe06', 'e0b91709-8c8d-4396-8aae-1aec1b66fdd7');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ce845442-0c3d-4de6-bbe6-765445fbfe06', 'f06dfa92-fc5a-4a8f-8b50-045720cf54ce');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ce845442-0c3d-4de6-bbe6-765445fbfe06', '85659db5-9f04-4f40-abfb-88d79ee46520');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ce845442-0c3d-4de6-bbe6-765445fbfe06', 'f9d89576-54c8-47f1-9d8d-2333734b65f8');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ce845442-0c3d-4de6-bbe6-765445fbfe06', '7b6d54b5-fa55-4382-be72-f747bad7417e');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', 'cc00c356-dbee-4e3f-9cb0-b44eda2e3e4b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', 'cb717fe1-74c8-4971-b740-d2d652dd1c41');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', '2b12a446-4220-4cfc-b4de-debe9ba0350a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', '68b87841-9f59-414c-942c-446ff38b225b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', '62e80cc5-e273-4dc2-8003-48cd4998e516');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'c1c06c13-6f5e-49b6-a948-048f2c8bb455', '3ce63e14-c932-4217-8575-a147a6586eeb');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '6410632f-390a-4cc6-8a86-ebdc4aa42ec8');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '5de24cd6-0cc8-4243-bbf7-a8ce782489a2');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '7f2522d7-5624-4cc9-a650-fa3658c925b0');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', '747b45af-0497-4668-95ac-9c135897bc3f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '5637ebba-7d13-48c3-ac39-8d9e2f1fcab0', 'a2f68fad-3ac8-4993-bc77-0609d22b32c0');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '61240d41-e0e0-4f01-8315-01c8e433eaf9', 'c02a0102-0ca0-47fc-bab7-624e8399194f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '61240d41-e0e0-4f01-8315-01c8e433eaf9', 'aa9b7096-b66e-4333-a985-499c564b034f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '61240d41-e0e0-4f01-8315-01c8e433eaf9', '41aeda21-168e-4dd7-97c3-f0491ac8a384');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '61240d41-e0e0-4f01-8315-01c8e433eaf9', '9a167ae3-3a6f-42e5-9f40-493df46ff3ca');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9b66ba2c-d515-4710-8312-336840750dc1', '02588968-66cb-4567-b248-ee915fc77758');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9b66ba2c-d515-4710-8312-336840750dc1', '697a8302-de94-48d7-acd2-9e6194b8a514');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9b66ba2c-d515-4710-8312-336840750dc1', '2ef714e8-f94a-4511-a648-9871b1642982');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9b66ba2c-d515-4710-8312-336840750dc1', 'f5ce9e9d-dbe5-41fc-8a8e-bc12474bb54f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '9b66ba2c-d515-4710-8312-336840750dc1', '86dde6ab-12aa-401c-b92d-83160d21be07');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0', '0b543673-4122-4f09-9489-4f598e1863ce');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0', '3b648229-1ae9-44b0-b110-795144560724');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0', '76c987e8-8ced-4eca-a880-d0c4c7c022bd');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'caef84fa-0019-4a13-b4c2-c6c11e3f94e0', '4f0299ab-f1d6-4024-a818-6b0f07a1b57a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '6db88066-a65a-4b3b-8f33-ac536a0f44e8', '72351141-4690-418a-ab49-5fc266bcde68');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'a92bd2e9-498b-4bcb-8c47-7a1acbe17a3c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'de77a950-8e84-457d-b7b8-0443e6ebefe7');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '6db88066-a65a-4b3b-8f33-ac536a0f44e8', 'cba2963d-4aa1-4c97-9e43-f7122cff4c55');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '6db88066-a65a-4b3b-8f33-ac536a0f44e8', '9773f4f2-0c18-47d0-8c18-a566e51a2353');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', '122ce3a7-5108-4093-a2ce-98b0d92a3064');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', '328b76e2-e5bf-40f2-b932-55035adbd3ed');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', 'fa37af48-c661-4f27-a98b-2418bfe893b3');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', 'c87a7c57-f62e-488a-89d0-3a2a066d9f4b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', '7c0e8f4c-e63b-43c5-ad93-357c4ab22a43');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'f65a45d6-d4d1-4f97-9959-233bf7a2f88e', 'dc44054b-3fe5-4c01-adc7-46b10405247d');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '80c78721-2a0d-4a7d-aca6-28513b321eee', 'b440b7de-c36f-46ce-ba9b-fc9e60558621');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '80c78721-2a0d-4a7d-aca6-28513b321eee', '16d2527d-07b4-463d-9fc9-6065d521edab');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '80c78721-2a0d-4a7d-aca6-28513b321eee', 'b4a79808-a9d4-46f5-9ba6-3481a5605a93');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '80c78721-2a0d-4a7d-aca6-28513b321eee', '69232c5a-00f6-4275-9798-19c5de2de367');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', '19c26b27-0805-4d79-8a3b-e4693d07f074');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', '0f7f5356-ab29-463a-ac1c-d557f77fd1ea');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', 'd054bcd5-05ee-421d-85e5-e73754034061');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '1ae56dcb-6f4b-4e77-bade-0cb2dc3ac827', '504c44c2-7371-4b99-be54-a988c211ea39');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '6d635e86-f2fb-44a6-8e10-cbdd7ef21f5c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '63165c20-1c2d-478d-83b6-225e7d4964a6');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '5207e561-bc10-4a2f-af1f-07c0273ce717');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '0962e7e2-ca97-48ec-a9c0-8aa87f4cf573');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'ba935e44-3c0f-41f3-9467-154a61f3d4c5', '4dcd8570-4b45-4806-93e6-5f5123c57455');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'eaa51591-8133-4516-9db3-8848b9571cd9', '0d6e8529-998d-40dd-b048-fdb7c8685efa');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'eaa51591-8133-4516-9db3-8848b9571cd9', '9152f72e-7bb5-4ef0-93f1-dbdaca4e5f2e');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'eaa51591-8133-4516-9db3-8848b9571cd9', 'bef352b7-824a-45af-877e-74c4eb0e996d');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'eaa51591-8133-4516-9db3-8848b9571cd9', '520bbd96-53fc-4500-981d-651687e36258');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'eaa51591-8133-4516-9db3-8848b9571cd9', '3384c462-7cdf-46b6-b83f-dc571709a61b');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, 'eaa51591-8133-4516-9db3-8848b9571cd9', '711196d2-c155-40e7-84a9-eedee40b882a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'c529bc42-8bc1-462a-b08a-a9eb0d2fe311');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '469ed793-d86f-4dff-b2fc-70b77e83a0eb', '69f519f6-19ee-4c97-883a-f8416d75ad2c');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '469ed793-d86f-4dff-b2fc-70b77e83a0eb', '868a1f17-d5d3-43fd-85cc-c3de38d12038');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '469ed793-d86f-4dff-b2fc-70b77e83a0eb', 'b02e77db-a2d3-441e-89ea-f993d82a0ba7');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '469ed793-d86f-4dff-b2fc-70b77e83a0eb', '265e1cb3-2a86-410b-bf9f-a8b7983311b2');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'afc2df53-9728-4108-a3b6-b164044ef33f');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'bfe72beb-d220-40a0-854a-d129979a2d89');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '07300d73-2d8d-46d6-a735-c1caa0bddaf0', 'fe78ea63-8eb3-496b-9931-90430f1a864a');
INSERT INTO public.question_kc_mapping (weight, kc_id, question_id) VALUES (1, '07300d73-2d8d-46d6-a735-c1caa0bddaf0', '46e76d0c-a956-47d0-aa16-08b2e36ea235');


--
-- Data for Name: scaffolds; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a5ac4e35-eac4-4e71-bee8-4eddd314b4ce', 'bd59834c-e353-4bf6-b9bb-7e5c1c684db1', 'Superclass or parent class', 'What is the class that **other classes inherit from** called?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '44504bb0-41e4-4434-a968-5714eb084a44', '7b09e392-5968-4cb5-9b23-07c1989ce164', 'To avoid code duplication and promote reuse', 'What is the benefit of putting shared methods in a superclass?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a5ac4e35-eac4-4e71-bee8-4eddd314b4ce', '981e7a9a-149c-4963-82eb-3889cb870c86', 'Subclass or child class', 'What is the class that **inherits from another class** called?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '642c4a8d-7295-4822-84cd-6c589067b053', 'e16adc1d-5a3a-4456-a406-409b8dd06655', '`extends`', 'In `class Car ___ Vehicle { }`, which keyword completes the inheritance?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'ffd422dc-dbc7-4a41-a002-91aa03e70dd9', '118fc17c-de05-4357-a332-6815cc2a6720', 'Yes, by overriding the method', 'Can a subclass change how an inherited method behaves?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'feec1a5d-9095-482d-861a-a698b8b0827c', 'd49b83ca-b134-45be-80c0-fda2f94a75b0', 'A subclass inherits features from the superclass and can add its own', 'If a superclass is like a **template**, what is the role of a subclass?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3ade7bbc-8cbc-4e63-8938-1f3ceb75f941', '7a6c6998-2562-4d21-b865-737a567ff2b6', '`extends`.', 'What keyword must `Car` use to indicate that it inherits properties and behaviours from `Vehicle`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8d256539-243c-47a4-a5cf-eed9f5eacfd3', 'e8209240-a427-46bb-9568-6caac4526579', '`abstract`.', 'What keyword explicitly tells the Java compiler that a class or method cannot be directly instantiated or implemented, respectively?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '35c97850-9c82-42fa-917f-c8ee852c54c4', '94e99bc2-0c34-4036-8264-1196f1cbc479', '`Circle` must provide a concrete implementation for the `draw()` method.', 'If an abstract `Shape` class has an abstract method `draw()`, and a `Circle` class `extends Shape`, what must `Circle` do with `draw()` for `Circle` to be a non-abstract class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '73728c43-0dbd-4de1-8e21-65a519874c83', '0d3840c7-6355-4c22-a715-7995cf7687e5', 'No, you only interact with its simplified interface.', 'If you use a remote control for a television, do you need to know how the television changes channels internally to use it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3ade7bbc-8cbc-4e63-8938-1f3ceb75f941', 'ffef9fdf-15b9-4a59-b8f7-69ffb5e96dbc', '`@Override`.', 'To indicate that a method in a subclass is providing an implementation for a method defined in a superclass or interface, what annotation is commonly used in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0003e2a5-2711-49ca-95ed-a361b61bc418', '434b867f-04b7-4b32-ab72-79a8d9f282d3', '`public abstract class Shape`.', 'If a class `Shape` is designed to be a blueprint for other shapes but cannot be directly created, how would you start its declaration in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8d256539-243c-47a4-a5cf-eed9f5eacfd3', 'c8bbeac2-d45f-46ae-bed1-4e78e3319790', 'Yes, an abstract class can contain concrete methods. These are methods with an implementation that are common to all subclasses and do not need to be overridden.', 'Can an abstract class contain non-abstract (concrete) methods? If so, what is the purpose of having them?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '32c9b366-417a-4b4c-b717-ecdfde1e87d3', '96021731-8f05-4935-8e5f-a70425d592a4', 'Provide its own implementation', 'If a superclass method is abstract, what must the subclass do?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f7fd4704-fd08-412d-b755-f9462210bfac', '6f4ee59e-9a3b-4c2d-93a2-72d915bd4d32', '```java
class Animal {
    void eat() { }
}
```', 'Define a simple `Animal` superclass with one method, e.g., `eat()`.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '7f9befc5-45dc-4f2b-9a6b-9de14edae151', '9d5c6dff-0fa1-486b-aaa9-d611dc4cb4df', 'It shows the child is a specific type of the parent', 'What does ''is-a'' establish between a child class and parent class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '07a34361-54aa-456e-8e3e-f33ab7e54baf', '2b7c8e29-5222-4d1f-8c12-1fea891bbdcf', 'Inheritance', 'What concept lets a class **reuse behavior** from another class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '02785fc6-3f61-4ffd-8b2b-0c55d72a20e0', '11ee4a35-6a9b-49de-8212-c0e7290e09be', '`extends`', 'Which Java keyword shows that one class inherits from another?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f7fd4704-fd08-412d-b755-f9462210bfac', '4c1956b3-a460-4f99-af9f-20ea95d12036', '```java
class Bird extends Animal {
    void fly() { }
}
```', 'Create a `Bird` subclass that inherits from `Animal` and add a method `fly()`. How does Bird relate to Animal?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '32c9b366-417a-4b4c-b717-ecdfde1e87d3', '317cbfa4-0468-41f2-a69a-e30b8352d36d', 'To define behavior that subclasses must implement', 'Why do abstract methods exist in a superclass?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '07a34361-54aa-456e-8e3e-f33ab7e54baf', '03de94b1-2d7a-4879-91de-03cd4971cce7', '''Is-a'' relationship', 'If a Car is considered a type of Vehicle, what kind of relationship is this?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '02785fc6-3f61-4ffd-8b2b-0c55d72a20e0', '2692aec5-9967-4259-91cc-1d13ac7533d9', 'Circle ''is-a'' Shape', 'If Circle inherits from Shape, how would you describe their relationship?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '7f9befc5-45dc-4f2b-9a6b-9de14edae151', '1cfdf6f6-c7cf-4594-be98-6e70622624c4', 'It allows common attributes and behaviors to be shared in the superclass, reducing duplication', 'How does an ''is-a'' relationship help organize code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'ea50d206-0377-4a0d-9874-64993cc01d6f', '3131256e-a415-48e4-af32-9d18b0d2faa4', 'In the common superclass', 'If Dog and Cat need the same method, where should it be placed for reuse?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'ea50d206-0377-4a0d-9874-64993cc01d6f', '81d272d7-bdb6-4854-ad6b-0db34654e0c3', 'Updating it once applies to all subclasses', 'What benefit does putting shared code in a superclass offer besides less writing?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'fe1cf1ab-2d94-4ff9-b4b4-451a50dc2024', '678abf21-2207-43ef-b905-899a879d17a1', 'It means the method has no implementation.', 'What does the term ''abstract'' imply about a method''s implementation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'fe1cf1ab-2d94-4ff9-b4b4-451a50dc2024', '63186bf1-b99c-4846-b8b0-302a63eb7594', 'In its concrete subclasses.', 'If a method is abstract, where does its actual code live?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'dcb1de41-8588-483d-9e02-77715c9a95c5', '4b00aa67-06c3-4f33-a8d0-3f57a4af8447', '`extends`', 'What keyword is used in Java to signify that one class inherits from another?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'dcb1de41-8588-483d-9e02-77715c9a95c5', 'e6027e6c-fe89-4085-9301-76bf601f4da2', 'A method body, enclosed in curly braces `{}`.', 'An abstract method has no body. What does a concrete method have?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c1504e54-0457-462b-97ca-5d6f3a42f676', '9d014b5b-e5d1-4a66-866a-1c2f51d80c9a', 'An abstract method has no method body or implementation.', 'What is the key characteristic of an abstract method that distinguishes it from a regular method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c1504e54-0457-462b-97ca-5d6f3a42f676', 'ce021340-d912-4119-b821-4445c5b458c9', 'It guarantees that every concrete `Shape` subclass (e.g., `Circle`, `Rectangle`) will have a `calcArea()` method defined.', 'If a `Shape` abstract class has an abstract `calcArea()` method, what does this guarantee about any concrete `Shape` subclass?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '79f145b2-3430-443d-a11b-ed2522d1a3df', 'e96fdc12-34be-4959-bd07-eae8387eaf9c', 'Perform different actions based on their type.', 'What does polymorphism allow objects of different types to do when responding to the same message?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '79f145b2-3430-443d-a11b-ed2522d1a3df', '81941364-9e7e-4703-8f63-400d8413bafe', 'The `Circle` class provides the concrete logic for drawing itself.', 'How does an abstract `draw()` method in a `Shape` class become useful for drawing a specific `Circle`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '9f0cdb7c-0837-479d-949e-3e68500974b1', '09dbb827-02e3-4080-804f-8a82da58225b', '```java
public abstract class Vehicle {
    public abstract void drive();
}
```', 'Create an abstract class named `Vehicle` with an abstract method called `drive()`.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '9f0cdb7c-0837-479d-949e-3e68500974b1', 'ec21025d-571a-432c-96e3-e2d6f7ee7a8f', '```java
public class Car extends Vehicle {
    @Override
    public void drive() {
        System.out.println("Car is driving.");
    }
}
```', 'Now, create a concrete subclass named `Car` that extends `Vehicle` and provides the concrete implementation for the `drive()` method.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c94e5bb0-f813-4bfb-8bda-6fcadb1e1f0f', 'ca036bab-f161-40ae-a05e-cad4a52e0a2c', 'It contains one or more abstract methods.', 'What characteristic defines a class as ''abstract''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c94e5bb0-f813-4bfb-8bda-6fcadb1e1f0f', '13b15eea-1309-4d87-896c-6696a0a3d758', 'Abstract classes cannot be directly instantiated.', 'What is the primary restriction on creating objects from an abstract class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'ad557157-7408-48c4-9818-2671d40934eb', '90f2762f-9a42-4d76-980b-fad5565c4cc3', 'To make it easier to understand and use.', 'What is the main goal of making a complex system appear simpler to its user?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3c68f975-fa03-45a7-ba24-d832077c6b3f', 'f1ce60ba-53df-4786-824f-4b4f55e4e25a', 'It makes the system rigid and harder to maintain.', 'What happens if a change to a system''s internal workings also forces external users to change their interaction methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'ad557157-7408-48c4-9818-2671d40934eb', '8ec2a9ef-43db-4584-86f9-df9832670f57', 'Just that it allows you to turn the car.', 'When interacting with a car''s steering wheel, are you concerned with how the power steering mechanism works, or just that it allows you to turn the car?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3c68f975-fa03-45a7-ba24-d832077c6b3f', '165591fc-a8ba-4c2d-87b6-896ed2ee7635', 'No, the interface (buttons) remains stable.', 'Consider a television. If the internal components are upgraded, does the user need to learn new buttons to change channels?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '4f0cbbc6-c474-4e0c-9320-b296775bc1b2', '35dad954-81d4-4e53-9ac7-793d036dfdd2', 'The complex internal details or ''how'' something works.', 'What does an abstract interface hide from the user?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a34bbf1b-b3df-4738-a4e4-6f29b0caf125', '7523ec73-af35-4fff-843e-fc0a62990fd5', 'Its name, what arguments it takes, and what type of value it returns.', 'If you call a method, what information do you need to know about it from its public definition?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '4f0cbbc6-c474-4e0c-9320-b296775bc1b2', 'd22db4d5-a979-4584-ad14-722200af62c2', 'It allows the internal implementation to be swapped or modified without affecting the external interface the user interacts with.', 'How does hiding these details help with adapting to new requirements or changes?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a34bbf1b-b3df-4738-a4e4-6f29b0caf125', '4d2d99e1-13bd-43fe-aba0-93b6399033e4', 'The method body or implementation.', 'What part of a method contains the actual lines of code that perform its specific task?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c7a789dd-c64a-4153-901f-bc24d9762b23', 'd0704eac-29da-41c0-9d82-9e89a6abbe05', 'It creates tight coupling, making the class harder to change or maintain without affecting other parts of the system.', 'What is the primary risk of a class exposing too many of its internal details or non-essential functionalities?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '1ebdbf0d-2817-4628-8784-7a081f246251', '82de179d-57a2-4f92-a82f-53d178658489', 'To allow other objects or parts of the system to call or access it.', 'What is the purpose of making a method `public` in a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c7a789dd-c64a-4153-901f-bc24d9762b23', 'b2fc475b-60d1-4190-98cc-28bb7f4c4122', 'It creates a clear boundary, ensuring that internal changes do not necessitate changes in how other classes interact with it.', 'How does limiting what''s public help a class''s interface remain stable even if its internal operations evolve?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '1ebdbf0d-2817-4628-8784-7a081f246251', '784c3c92-c394-4b87-99de-0dc82da2a8b6', 'The class''s interface.', 'What concept defines the external view of a class, outlining its available operations without revealing internal logic?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '05ca5bdb-7bc7-4b08-9ef8-e97179de990e', '475d3943-d4a7-4fa4-9ec3-6e2cc5cf1c74', 'To make it easier to understand and use.', 'What is the main goal of making a complex system appear simpler to its user?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '05ca5bdb-7bc7-4b08-9ef8-e97179de990e', 'e8c1fdd3-6d34-46d7-8599-82adc0e3cc04', 'Just that it allows you to turn the car.', 'When interacting with a car''s steering wheel, are you concerned with how the power steering mechanism works, or just that it allows you to turn the car?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '154bbdc2-abff-4c83-bd3c-4cdc1ec7e1ca', 'da593e1a-b840-4748-87ce-5ae3e275bbd6', 'The complex internal details or ''how'' something works.', 'What does an abstract interface hide from the user?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd9a55a8d-727b-4159-b707-eedf74787ef0', 'a7151c60-d4be-4d54-9f9f-023221d88695', 'It makes the system rigid and harder to maintain.', 'What happens if a change to a system''s internal workings also forces external users to change their interaction methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd9a55a8d-727b-4159-b707-eedf74787ef0', '069e0406-d77e-423b-954d-290bd1497056', 'No, the interface (buttons) remains stable.', 'Consider a television. If the internal components are upgraded, does the user need to learn new buttons to change channels?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '154bbdc2-abff-4c83-bd3c-4cdc1ec7e1ca', '053861cf-906b-449b-bc7d-e0749ae99c63', 'It allows the internal implementation to be swapped or modified without affecting the external interface the user interacts with.', 'How does hiding these details help with adapting to new requirements or changes?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c1c917f6-47e9-43d6-9644-543511643a7e', '8d5aa1c2-ae0d-44c6-8a75-48e82d0cee2c', 'To allow other objects or parts of the system to call or access it.', 'What is the purpose of making a method `public` in a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c1c917f6-47e9-43d6-9644-543511643a7e', '417e18c6-94a0-4ac3-a117-0df8610a80ab', 'The class''s interface.', 'What concept defines the external view of a class, outlining its available operations without revealing internal logic?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '1d14c4fb-d009-4c10-9d82-36d79e9d7642', '4ca0be70-c333-49eb-859b-8d52612c6d5e', 'Its name, what arguments it takes, and what type of value it returns.', 'If you call a method, what information do you need to know about it from its public definition?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '1d14c4fb-d009-4c10-9d82-36d79e9d7642', '4f15938e-78d0-44b7-b88b-6fe18c627fa6', 'The method body or implementation.', 'What part of a method contains the actual lines of code that perform its specific task?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'efe8be5f-f686-4710-aac0-666b9ef5b86e', '78ae5b95-a239-4f9c-9361-4856bc590410', 'It creates tight coupling, making the class harder to change or maintain without affecting other parts of the system.', 'What is the primary risk of a class exposing too many of its internal details or non-essential functionalities?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'efe8be5f-f686-4710-aac0-666b9ef5b86e', '28e32fa3-6689-404c-a057-c4e6ca20ac61', 'It creates a clear boundary, ensuring that internal changes do not necessitate changes in how other classes interact with it.', 'How does limiting what''s public help a class''s interface remain stable even if its internal operations evolve?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8b39feab-7d75-4c8d-b1cd-177a6f23ecdf', '24974f72-f7ba-4a2c-b44a-c2825c56f227', 'To make it easier to understand and use.', 'What is the main goal of making a complex system appear simpler to its user?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8b39feab-7d75-4c8d-b1cd-177a6f23ecdf', '524ffd23-3bbd-4ada-844e-2c61c779acfd', 'Just that it allows you to turn the car.', 'When interacting with a car''s steering wheel, are you concerned with how the power steering mechanism works, or just that it allows you to turn the car?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a58e3c86-b89e-4c45-b5d1-ffd972671849', '938a1291-d4ff-4f50-b066-e3e6ca9c86c6', 'The complex internal details or ''how'' something works.', 'What does an abstract interface hide from the user?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e57fa057-585c-4abb-95ec-320343fb6cf5', 'f7e9b473-ec65-4819-aed8-3eed3d4e0d14', 'It makes the system rigid and harder to maintain.', 'What happens if a change to a system''s internal workings also forces external users to change their interaction methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a58e3c86-b89e-4c45-b5d1-ffd972671849', 'a3d74e1c-77a1-4d8d-8526-61ad4962717d', 'It allows the internal implementation to be swapped or modified without affecting the external interface the user interacts with.', 'How does hiding these details help with adapting to new requirements or changes?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e57fa057-585c-4abb-95ec-320343fb6cf5', '1a3a8f1c-8a9b-4e36-8065-6c894fd2e612', 'No, the interface (buttons) remains stable.', 'Consider a television. If the internal components are upgraded, does the user need to learn new buttons to change channels?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '05451828-5f5f-4066-b83b-f22af4a617f7', '7c361271-9d66-4c03-94c7-3f7df0e5fc21', 'To allow other objects or parts of the system to call or access it.', 'What is the purpose of making a method `public` in a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '05451828-5f5f-4066-b83b-f22af4a617f7', '6067f679-e5af-48eb-ab66-8921210b827d', 'The class''s interface.', 'What concept defines the external view of a class, outlining its available operations without revealing internal logic?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '985cc2aa-9595-4ba0-a70a-2451b5ddc8a6', '69e82c8c-e3d9-445e-baee-e90cca3ea516', 'Its name, what arguments it takes, and what type of value it returns.', 'If you call a method, what information do you need to know about it from its public definition?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e84854d9-db4b-40ef-ba4b-478218616486', 'cd05375f-822e-4c95-933f-8ae36635fd1e', 'Just a blueprint or definition.', 'What is a class without an object?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'feb4a19d-55b1-4e3d-8614-17cc940d2f67', 'f7209a60-fe93-4c81-bbb3-dcf74562d7dc', 'It creates tight coupling, making the class harder to change or maintain without affecting other parts of the system.', 'What is the primary risk of a class exposing too many of its internal details or non-essential functionalities?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'feb4a19d-55b1-4e3d-8614-17cc940d2f67', '1452657e-c8a6-432a-bf41-fce15f6f1a95', 'It creates a clear boundary, ensuring that internal changes do not necessitate changes in how other classes interact with it.', 'How does limiting what''s public help a class''s interface remain stable even if its internal operations evolve?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '985cc2aa-9595-4ba0-a70a-2451b5ddc8a6', '2f163583-38bc-421b-84ab-9693e7094e6f', 'The method body or implementation.', 'What part of a method contains the actual lines of code that perform its specific task?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'ff5a4a81-fdab-479b-9424-e3e9b5801553', '6d9f7dfa-fcd9-47f5-b90a-21a2b321bb27', 'It is a more general or high-level command.', 'What is the primary characteristic of the ''Take me to the airport'' example compared to ''Turn right, then left''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '34d82057-a293-4f9a-86ef-df067ca2909e', 'feb12685-a647-4687-9961-2e00d74b8037', 'That the destination (airport) can still be reached by the same request.', 'If the way a ''driver'' takes you to the airport changes (e.g., a new route), what is the most important thing for you as the ''passenger'' (user) to know?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'ff5a4a81-fdab-479b-9424-e3e9b5801553', '016b4f42-34a1-443d-9c86-6d6cac7c72af', 'It allows for many diverse or specific ways to achieve the goal.', 'How does defining a general goal rather than specific steps affect how many different ways that goal can be achieved?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'cde20b6e-eea6-4e55-b944-1df6fadb2528', '43b31beb-7199-47ae-9c57-9653ed825e2e', '`interface`', 'Which Java construct is specifically designed to define a set of methods that a class must implement, without providing any method bodies?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'cde20b6e-eea6-4e55-b944-1df6fadb2528', 'aad868dd-f9ab-4e47-8f02-eddebb0ed690', 'It specifies ''what'' needs to be done, leaving ''how'' it''s done to implementing classes.', 'How does defining a method without a body (e.g., `void methodName();`) contribute to an interface''s abstract nature?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '34d82057-a293-4f9a-86ef-df067ca2909e', 'd2ce9da7-80fa-4e9c-a69d-6dd4f553c44b', 'It reduces the need for cascading changes across dependent modules.', 'How does changing internal logic without changing the public contract benefit a software system?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e5c0f586-2eff-4f41-abdc-09c9b61e689e', '8c3d9f72-d23e-4c01-8c61-bce8dee2b55c', 'A general goal can be achieved through multiple paths, while specific instructions limit the path.', 'What is the key difference between a general goal (like ''Take me to the airport'') and a specific instruction (like ''Turn right, then left'')?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c2204b5d-e5dd-4d7c-9751-6f2a071f8200', '47f07a95-bef4-4bd3-9214-d8c5f9cc084a', 'Their names and parameters (the public interface).', 'What does a user of a class need to know about its methods: their names and parameters, or their internal code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '2705f7df-f1f1-4c99-89a9-b97639d0cc30', '4e78ba38-f0d5-4c37-943e-7449aabd5cab', '```java
interface Transportable {
    void transport(String item);
}
```', 'Create a Java interface that declares a method for performing a general action, like ''transporting''.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'fb960709-a4bd-41c0-8910-608b719b65af', '0ff5e0d1-4373-4fb8-a799-bc6133066084', 'It becomes difficult or impossible to reuse that interface for other ways of achieving the same general goal.', 'What problem arises if an interface is designed based on a single, highly specific way of achieving a goal?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c2204b5d-e5dd-4d7c-9751-6f2a071f8200', 'b2bce307-7b5a-4cae-b4a7-cab213bc4fae', 'Other classes are unaffected and do not need to change.', 'If a class''s internal logic changes, but its public methods remain the same, what impact does this have on other classes that use it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e5c0f586-2eff-4f41-abdc-09c9b61e689e', '56706fcc-d009-4e33-99f5-93a640bcf9a8', 'It increases the number of scenarios or classes that can use the interface.', 'How does this flexibility impact the number of different scenarios or classes that can use the same interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'fb960709-a4bd-41c0-8910-608b719b65af', 'b608d67e-120e-4eef-8914-4b573a36e327', 'It allows different specific ''methods'' to achieve the same ''goal'' depending on the context.', 'How does defining a ''goal'' rather than a ''method'' make an interface more versatile for different situations?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '2705f7df-f1f1-4c99-89a9-b97639d0cc30', 'da64f115-9b74-463d-afa1-bbe80a08dac0', '```java
class Truck implements Transportable {
    public void transport(String item) { /* truck logic */ }
}
class Drone implements Transportable {
    public void transport(String item) { /* drone logic */ }
}
```', 'Implement this interface in two distinct classes, showing different ways to perform the ''transporting'' action (e.g., ''Truck'' and ''Drone'').');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '7805bbf6-6a55-4dd9-abc3-32182da43799', '86588881-23a1-4a05-ad03-201e5ae14146', 'Methods', 'What is the OOP term for the actions or functions an object can perform?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '7805bbf6-6a55-4dd9-abc3-32182da43799', '08a2b331-1d47-42ad-9321-69f19d0453b1', 'A behavior (or method)', 'If a `Dog` object can `bark()`, what does `bark()` represent?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'edbab82e-1826-4efb-b07f-f7d684d9bc50', '8b6fa9f7-2f5e-48c1-8862-dc9a13563376', 'The users of the class', 'When designing a class, who is the ''audience'' whose needs must be considered?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'edbab82e-1826-4efb-b07f-f7d684d9bc50', '0f765dcd-655f-428b-9148-df85234abdf6', 'Provide the minimal interface possible', 'What is the general rule for the public interface when considering user needs?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0d5f0624-1d15-4004-87e9-3d7743f90e8c', '77425998-9acc-4e53-9e89-e227fd795f8e', 'The users', 'Who primarily defines what an object should be able to do from a functional standpoint?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'eb79b12f-a85f-475f-816e-bdde79fe19f4', '5cb12634-bebc-497f-b430-5d5b63079188', 'Computer hardware or network availability', 'What kind of limitations are mentioned as being imposed by the environment?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '973ab281-fd9b-4760-a64c-f49a9b59b314', '2d975fc5-8ee4-43ad-98e8-f37d8d6bb50b', 'To be switched on or off', 'What simple action would a user expect a `SmartLight` to perform?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '0d5f0624-1d15-4004-87e9-3d7743f90e8c', '90d68b08-3e78-4fc0-8dbf-a48f8e52e78b', 'Behaviors or methods', 'What is the object-oriented term for ''what an object can do''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '515d04cd-f8ec-4910-ac7f-721d95562b65', '0bc28d99-717d-4b88-8d9e-f88b49c22657', 'Network connectivity (e.g., Wi-Fi, internet)', 'What kind of external conditions might restrict a `SmartThermostat`''s advanced features?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'eb79b12f-a85f-475f-816e-bdde79fe19f4', '169d0a12-70b4-4490-8d72-3e197c3f8387', 'An environmental constraint', 'If a remote-controlled `Drone` object cannot connect to the internet, what is the internet''s status considered?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '973ab281-fd9b-4760-a64c-f49a9b59b314', 'cf2448c3-bcf1-459a-a6b1-bfba06fd2291', 'Electricity/Power supply', 'What external factor is absolutely essential for an electronic device like a smart light to function?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '515d04cd-f8ec-4910-ac7f-721d95562b65', 'd9d7cf2a-e709-4b2e-a80f-fdc9082baaf6', 'It might revert to basic, offline modes', 'If a device loses its network connection, how might its functionality change to adapt to this constraint?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e1ed95f4-7a5c-4fb1-9195-73ee1a7fd8a5', '6c4ae5c0-cf89-4bd4-93f1-34ae5df42894', 'Other classes, human users, or system components.', 'What types of entities might need to perform an action using a class''s functionality?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e1ed95f4-7a5c-4fb1-9195-73ee1a7fd8a5', '9b5db0a9-d146-43f6-8d7a-ba67fd50d4fd', 'Interaction can be both direct (human) and programmatic (other objects/systems).', 'Does interaction always imply direct human input or can it be programmatic?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd1c3ed01-5297-4f3e-8a60-5400867c65cd', '3e8268b0-0daa-4259-83a3-016acefa045e', 'A customer or another system component like a shopping cart.', 'Who or what initiates a payment process?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd1c3ed01-5297-4f3e-8a60-5400867c65cd', '26e9f898-c6f9-4dfe-b86c-f46850b1ca31', 'It might need to be stored in a database, making the database a ''user'' of the class''s services.', 'What needs to happen with the payment information after processing, and what entity would be responsible for that?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '35334e96-d0bb-4935-8f22-e968575056b4', '883ead9a-0a3a-4cf1-8c1a-53e1cc96b0ed', 'The person operating it via a physical switch, app, or voice.', 'Who is the primary human interaction point for a smart light?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '46ab0646-3b78-490d-81c5-9435a5861a90', '7b975faa-a7c2-4d2b-9a62-9a4f82a75994', 'The user might be unable to properly interact with or use the class’s functionality.', 'If a user''s needs are not considered, what might be the consequence for that user''s ability to interact with the class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '35334e96-d0bb-4935-8f22-e968575056b4', 'ab9e3f80-c9dc-4f17-92bb-a93a6f42f5e1', 'A home automation hub to schedule lighting changes, or a security system to flash lights during an alarm.', 'What other automated systems might need to communicate with a smart light, and for what purpose?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '46ab0646-3b78-490d-81c5-9435a5861a90', 'b19cc489-fb27-42d2-971c-3fb58dfacd13', 'It allows the interface to accommodate various interaction styles and requirements, making it more intuitive and effective for everyone.', 'How does understanding different user perspectives contribute to the ''usability'' of an interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c027d03c-5c65-47f6-9a13-a418e6b792b6', '10780639-3e94-4322-a960-5e8127a18fca', 'Methods', 'What part of a class do other objects call to request an action?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'be8aa773-2d03-42a5-8ad3-ec04bf5f022c', '29fe24da-e6f7-4890-8a9e-ef0ea26a70fd', 'Document data (text, images, formatting).', 'What kind of data does a printer typically receive to perform its primary function?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'be8aa773-2d03-42a5-8ad3-ec04bf5f022c', 'a93c4bcf-cd5d-4165-83bb-1b5eaca4e057', 'A print spooler or print queue.', 'What system component often acts as an intermediary between an application and a physical printer?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a117a00a-194f-493c-90dd-036707b26568', 'e3c741df-bc57-492b-975a-11e22e4833fe', 'No', 'If a method''s *internal calculation* changes, should every program using that method need to be updated?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a117a00a-194f-493c-90dd-036707b26568', '725ff8f8-0244-4dcf-8e08-53abd28deb5c', 'Modularity / Maintainability', 'What design quality is improved when internal details are hidden, making components more independent?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '57b54c7a-c7ef-47c2-8bf2-aa351abbf02c', '5236d69f-d772-4eb2-8ee6-928158ea00c1', 'Ease of use, clear instructions, and safety (minimal distraction).', 'What is the primary concern for a human driver when using a navigation system?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '57b54c7a-c7ef-47c2-8bf2-aa351abbf02c', 'fec715b2-f5c9-4373-ad38-0e406bb112a2', 'Raw geographical data, traffic algorithms, and complex routing calculations, which are usually processed and simplified for the driver.', 'What kind of information does a mapping service typically process and how does it differ from what a driver directly sees?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'ad35ba58-7918-4923-a4cf-9b7e963d1961', 'ca5b3832-5ac9-4709-beb1-695f667a74bd', 'The services it provides and how to use them (method signatures)', 'What does a class''s public interface communicate to other objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'ad35ba58-7918-4923-a4cf-9b7e963d1961', '488c8789-63a5-4551-a925-268a940ebda8', 'Private attributes, private methods, and the logic within public methods', 'What elements constitute a class''s internal implementation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c027d03c-5c65-47f6-9a13-a418e6b792b6', '63490e99-8ca6-4b64-9a30-89307d5b5311', 'Just public methods', 'Are all methods visible to other objects, or just a subset?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '9f2604be-124c-451d-8d5b-983f80a98751', 'ee743256-ce63-4f2f-9085-f60f89ea11df', 'Private methods and attributes', 'What elements of a class are typically hidden from external access?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '9f2604be-124c-451d-8d5b-983f80a98751', '2b33c089-8655-48c3-8d53-eaf68c962707', 'No, just how to use its buttons (interface)', 'When you use a calculator, do you need to know exactly how it computes results internally?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'bfc5d85e-b231-4037-a1f6-9142e7fb50bd', '92067e76-0a44-4109-98a7-9aaee15dc60d', '`private`', 'What Java keyword is used to declare an attribute that can only be accessed from within its own class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'bfc5d85e-b231-4037-a1f6-9142e7fb50bd', '61b054ec-14a0-476a-86e2-330667e6e8f7', 'To prevent corruption, invalid states, or unauthorized changes', 'Why is it important for a class to control how its internal data is modified?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'eacbbb4f-993c-4307-8144-552cfdfaeff9', '8d5930e9-81d6-46d2-9e5a-ab82e3d47cc7', 'The method''s public signature (name, parameters, return type)', 'What is the *contract* that external code relies on when using a class''s method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'eacbbb4f-993c-4307-8144-552cfdfaeff9', '31005d20-ad04-465d-b387-66906d6dfd9f', 'No impact, they do not need to be changed or recompiled', 'If a class''s internal details change but its public method signatures remain the same, what impact does this have on other classes using it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'ca327a31-5a12-45be-9974-814191640a2b', '6e1cd6b5-71f5-453f-a070-9113192fd1df', 'The name of what is being built.', 'What is the first piece of information you would expect to see when looking at a blueprint?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'ca327a31-5a12-45be-9974-814191640a2b', '63533850-013c-4c63-ab5e-d86774962507', 'The top compartment.', 'In a standard three-compartment UML class diagram, which compartment is for identification?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '619f0ba2-97b9-413d-9e97-d1f2c3d273ca', 'ce9eb192-487b-4758-9b71-282a7dd36d3f', 'Data or properties.', 'What type of information do attributes typically represent?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c4715bd3-517b-425d-9bcf-f167262d5277', '74d63d19-7db0-4aed-82a2-1497104bfc9a', 'Attributes.', 'What do we call the data or properties that an object possesses?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '65c484a7-d54d-4cf1-9d19-9a63290029ea', '5b7f6a6d-14e0-41a3-afed-68f40193fa60', 'It performs actions or operations.', 'What does an object ''do'' in an Object-Oriented Program?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '619f0ba2-97b9-413d-9e97-d1f2c3d273ca', '2bd912c9-71c8-4ad0-9e58-6a5ba8177800', 'They define its specific state or characteristics.', 'How do these pieces of information help to define an individual object?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c4715bd3-517b-425d-9bcf-f167262d5277', '5efa5cb2-f33b-4a03-bcc3-b81c6a0388f2', 'In the section directly below the class name.', 'In a UML diagram, where are these properties listed?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'eafc849b-8947-42f2-a389-1af9984448c2', '0cda1a3c-1489-4c6a-9e78-dc1ab40cae7f', 'Its behaviors or operations.', 'What defines what an object ''can do''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '65c484a7-d54d-4cf1-9d19-9a63290029ea', '706df303-14e9-4e97-80ad-b4896b35ea63', 'Methods.', 'What UML component represents these actions or operations?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'eafc849b-8947-42f2-a389-1af9984448c2', 'bf7a6fce-7ab0-4b59-b1fa-04d54d26a4be', 'The methods compartment.', 'Which part of a UML class diagram lists these operations?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '98d159c6-bbca-4f86-ad25-74d43e7deb31', '65236d34-e1d3-4624-b2bb-ed68cd9eaab3', 'Class Name, Attributes, Methods.', 'List the three main compartments of a UML class diagram.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '98d159c6-bbca-4f86-ad25-74d43e7deb31', '6fbea604-744b-4c29-ba23-c0810aa904a4', '`title` and `numberOfPages` go in Attributes. `openBook()` goes in Methods.', 'Which compartment would contain `title` and `numberOfPages`? Which would contain `openBook()`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3633fbab-bcd9-4950-8d15-a33fc79d27f3', '63f4ae2f-087d-42a9-b534-9362cb025e0a', 'Behaviors.', 'What is the common term for an object''s ''doings''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '80e0e991-1c4f-4e10-8998-2c913bda0173', 'f3571dc1-0916-4e9b-a7f0-d146d544491a', 'Behaviors.', 'What aspects of a real-world object define its actions?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '80e0e991-1c4f-4e10-8998-2c913bda0173', '10520472-4548-4cef-a500-16b81c854962', 'Functions or procedures.', 'What programming construct typically implements these actions within a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3633fbab-bcd9-4950-8d15-a33fc79d27f3', '78365d17-020f-437a-bda2-d6fd18916837', 'In the methods compartment/section.', 'In a class, where are these doings formally declared?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b1adc3b9-38a9-4028-aad6-251108592819', 'cab51679-f550-435a-885c-080426867ad8', 'Interface.', 'What is the common term for the services a class offers to external users?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b1adc3b9-38a9-4028-aad6-251108592819', 'ad5da576-0875-462d-a7f6-71b6c485ed96', '`public`.', 'What keyword explicitly defines the visibility of elements that belong to this interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8aa229f7-ddbd-48c5-98df-b71a16f1790d', 'c6b307c3-40b5-4c87-b6ab-3981ef2d5542', 'Behaviors or actions.', 'What fundamental concept do methods represent for an object?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8aa229f7-ddbd-48c5-98df-b71a16f1790d', '73c01d42-1c3b-473a-a0d0-90df4a3e8d81', 'They combine data and behavior in one entity, supporting encapsulation.', 'How do methods, along with attributes, contribute to an object being a self-contained unit?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f50a4a8f-aa6a-41ec-b276-db271e9fa419', '4c0acebf-9679-45ca-a21f-65d4d0c5fe7e', 'e.g., `public void methodName() { /* code */ }`', 'What is the basic structure for defining a public method inside a class in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f50a4a8f-aa6a-41ec-b276-db271e9fa419', 'd009717c-6c82-4c4a-9ee0-a7b31fdea01f', 'Making a sound.', 'What kind of action does a dog typically perform that could be represented by a method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '88d37ef1-2aa8-462c-91d7-58e1dbb977b9', '547e6a85-bd69-4a73-82fe-ebd5327b10cd', 'Understanding, clarity.', 'What benefits does explanatory text provide in code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '88d37ef1-2aa8-462c-91d7-58e1dbb977b9', '5cd31590-428c-4d67-8f29-28e9763ce0ec', 'It makes maintenance easier.', 'How does clear understanding impact tasks like fixing bugs or adding features?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f7c8818a-70da-461a-8cd6-7bcd9ec592f2', '87ae8c8a-ab7f-412b-ac4f-c37991a447aa', 'Purpose and behavior.', 'What fundamental aspects of a class do comments help to clarify?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f3e2cd90-912c-44c3-998a-e6b3bf38511d', 'c756381f-0f61-41f5-9e13-2c3bd25a131a', '`/*`', 'What symbols are used to start a comment that can span across multiple lines?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f7c8818a-70da-461a-8cd6-7bcd9ec592f2', 'b913c4af-def4-4a21-945e-67c15c84179a', 'It facilitates maintenance.', 'How does this clarity impact future work on the class, such as bug fixes or feature additions?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f3e2cd90-912c-44c3-998a-e6b3bf38511d', '73f68fa5-6ea7-4faf-b03d-84a47c0c0c54', '`*/`', 'What symbols are used to explicitly end this type of comment?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd068acdf-93d0-4b60-aa34-acad18893d24', '5a951e62-264e-48c7-a919-6371e8898c69', '`//`, ends at line break.', 'What characters start a single-line comment, and where does it end?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd068acdf-93d0-4b60-aa34-acad18893d24', '595f938a-d975-412e-a3f7-c5e50648a204', '`/*` and `*/`.', 'What characters start and end a multi-line comment?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (2, 'd068acdf-93d0-4b60-aa34-acad18893d24', '1d375147-d380-430e-abd0-3df991d7965f', 'Subsequent code may be treated as comments.', 'What happens if a multi-line comment''s ending characters are missing?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '967d8f4c-60e0-40ef-9795-217aee6dbc6a', '8d84dff7-ec25-407a-ade5-575cfb08e8b5', '`//` followed by text.', 'How would you comment a single attribute on the same line?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '967d8f4c-60e0-40ef-9795-217aee6dbc6a', '23c9da5f-94c7-424f-86eb-5d4b65954ab8', 'Start with `/*` and end with `*/`.', 'How would you write a longer explanation for a method that spans multiple lines?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '382dbf51-54df-428c-a443-dc3f00368652', 'b77a70d1-4977-4b64-ac41-f9a31f22e5c9', 'It makes the interface concise and easier for users to understand and utilise.', 'What is the primary benefit of only providing *needed functionality* through an interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a22216a5-7c02-4dbd-b627-99057f2b9299', 'af5e68eb-23cb-4400-a6cd-78c95c03d72e', 'Interact with the class.', 'What do ''public'' methods allow other parts of a program to do with a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8946a048-2cb1-45a2-8cc6-14dd000710d1', 'fc24edcb-04f0-4553-98a8-12b21f275f1c', 'It focuses on what the class *does* (its purpose) rather than *how* it does it (its implementation).', 'What does it mean for an interface to be ''abstract'' in design?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '382dbf51-54df-428c-a443-dc3f00368652', 'dd761095-729d-46c7-a1c2-d8d1d7881ea6', 'It allows internal changes to be made without affecting or breaking external code that uses the class.', 'How does hiding *internal details* impact the ability to modify the class later?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a22216a5-7c02-4dbd-b627-99057f2b9299', '5a4fecf5-37b6-45a3-a76c-1d6b2daf00cc', 'An API (Application Programming Interface).', 'What is a collection of services a class provides to outside components?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8946a048-2cb1-45a2-8cc6-14dd000710d1', '9af23428-00a1-46d4-a061-d685852264f3', 'It exposes only the absolutely necessary functionality, nothing more.', 'What does it mean for an interface to be ''minimal''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c2d99813-7881-4e6d-98c1-ed22d048f251', '34cde479-efb7-42e1-a6fd-363d5942ac72', 'Direct coupling to the implementation details of the class.', 'What kind of dependency can arise if internal details are directly exposed to external users?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c2d99813-7881-4e6d-98c1-ed22d048f251', '165a3b40-7b82-4ebf-b858-1187d6459a4b', 'It significantly increases the complexity and risk of introducing breakage in external code when internal changes are made.', 'How does this type of dependency impact the effort required for class maintenance or updates?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '2eaab065-6616-46f2-9933-bc07bbf03945', '201b70d9-6eec-4b90-a15b-bc74b803ae36', 'A blueprint or a template.', 'What is a class considered before an object is made from it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '2eaab065-6616-46f2-9933-bc07bbf03945', 'deee6179-b7c8-480b-8077-310a3d4ef0a5', 'A concrete instance or object.', 'What kind of entity results from following a blueprint to create something real?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '1e9e28c9-9590-44bc-8971-2a29dbd2e4aa', '5e5950a3-b62b-4b99-a90e-684257c2ab76', 'Class.', 'What concept represents the general definition or template?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e84854d9-db4b-40ef-ba4b-478218616486', 'd27ced5c-2b60-48db-943d-e8d23e4329df', 'Utilise them or interact with them.', 'What does creating an object allow you to do with the class''s defined features?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'eca7d620-d9fe-4e39-b83b-4e2f86a9126a', '23859d58-f4de-4761-b482-dd3aeba6bb04', 'The sender object.', 'Which object is responsible for initiating the communication?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'eca7d620-d9fe-4e39-b83b-4e2f86a9126a', '579e0b05-9ffd-4457-8596-09a576b5801d', 'The method name and arguments (parameters).', 'What information does the sender provide to the receiver to specify an action?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '37391e56-d241-41a5-a7dc-0337efd3b083', '769d8ff3-9cbc-4d02-aecb-ccf33363a52a', 'To obtain or return something.', 'What is the general purpose of a method that starts with ''get''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '37391e56-d241-41a5-a7dc-0337efd3b083', '8ed9d80f-3645-4986-b8c3-263f8ee28fdc', 'Through public methods.', 'How do objects typically expose their internal data for viewing without allowing direct modification?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '1e9e28c9-9590-44bc-8971-2a29dbd2e4aa', '78eb305f-b23a-43fe-8d70-4d1fa14f3d67', 'Object (or instance).', 'What concept represents a specific, tangible item built from a template?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '2bfc0ea9-d292-4009-87af-67661206e9f5', 'a79d2b8c-d413-46ce-9971-584f4599e83e', '`Book`.', 'What type should the `myBook` variable be declared as?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '2bfc0ea9-d292-4009-87af-67661206e9f5', '852b0d09-faaf-4f64-bea7-cc380c6b6044', '`new ClassName()`.', 'What is the standard Java syntax for creating a new instance of a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '6157ccc8-f53d-4edf-9fab-db0e9c92c73f', 'f8291f4e-5965-4035-b310-8cbea17f4cda', 'They communicate with each other.', 'How do different parts (objects) of an object-oriented system interact?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '6157ccc8-f53d-4edf-9fab-db0e9c92c73f', '57a940fe-47fe-4594-bd09-91978f979a0b', 'By calling one of its methods.', 'What is the typical way an object ''tells'' another object to do something?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '9593327a-46a8-4b5c-8f3f-c74f415152c9', '911d6c24-774a-4268-b3d1-acc817bdb6bf', '```java
class Light {
    void turnOn() { /* ... */ }
}
```', 'Define a `Light` class with a public method `turnOn()`.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '9593327a-46a8-4b5c-8f3f-c74f415152c9', '67c4145c-d425-4bb6-9aa3-326b3f6d5eb0', '```java
class LightSwitch {
    Light myLight;
    void press() {
        myLight.turnOn();
    }
}
```', 'Define a `LightSwitch` class that holds an instance of `Light` and has a `press()` method that calls the `Light`''s `turnOn()` method.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5dbc1405-c207-4ffe-ad5c-71633ad29aa9', '3c25c5e1-90fd-4cdb-b4a6-23f9e1b80262', '`myCalculator`', 'What is the name of the object variable that the method `add` is being called on?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5dbc1405-c207-4ffe-ad5c-71633ad29aa9', '43eeac51-869d-4d07-8ece-f7a9ecc4eb5c', 'The `myCalculator` object.', 'Which entity is performing the calculation based on the request?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8d3c8c63-7c2a-4ae2-b052-a14f01bdcfd1', 'af4fa556-525d-43e1-8d5c-1e75e976d8a1', 'It can check or validate the incoming value.', 'What function can a setter perform before it assigns a value to a variable?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8d3c8c63-7c2a-4ae2-b052-a14f01bdcfd1', 'c407513e-cc78-4b56-afb9-2c8005a0a2cb', 'By including conditional logic to accept only valid values.', 'If a variable''s value must meet certain criteria (e.g., positive number), how can a setter help enforce this?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'fde1c387-3597-4a5c-8673-871ebb4ad75b', 'eeda9380-4bcd-4043-863c-4c77074e7407', 'To restrict direct access to the variable from outside the class.', 'What is the primary role of the `private` keyword for instance variables in a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '58e808a3-5068-4574-8363-08b530c39c85', '25575533-986c-49c5-84c9-bde3c475b017', 'To restrict direct access to the variable from outside the class.', 'What is the primary role of the `private` keyword for instance variables in a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'fde1c387-3597-4a5c-8673-871ebb4ad75b', 'cca09f4d-8eef-4566-bafc-5b3b84fdf35e', 'It helps to hide the object''s internal implementation details.', 'How does preventing direct external access to an object''s internal data relate to encapsulation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '58e808a3-5068-4574-8363-08b530c39c85', 'a1d1511e-6491-4ffa-8647-11a6eb3fe10d', 'They provide controlled, indirect access to the private data.', 'How do `public` getter and setter methods act as intermediaries between external code and a class''s internal data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '20fa95aa-aa2a-4af1-b70c-3edb8c95c546', '0dcadd82-885a-4b73-b74e-85eb8c3eb12c', 'A getter method.', 'If a piece of data should be known but never changed after initial creation, what kind of accessor method would be appropriate for reading its value?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '20fa95aa-aa2a-4af1-b70c-3edb8c95c546', 'b415884d-5598-48f4-8e67-d64fb78f8570', 'It ensures the identifier remains constant and unique.', 'How does restricting modification of an attribute like `productID` affect the reliability of that identifier?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '1aaabfab-be55-4b3d-b54e-0aff1e187e69', '7aa5f4ed-5817-4772-bf40-083726deaced', '`private int grade;`', 'How would you declare a private integer variable named `grade` in a Java class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '1aaabfab-be55-4b3d-b54e-0aff1e187e69', 'af493600-5e10-43b8-9047-b42b1a70953c', '`if (value >= min && value <= max) { this.variable = value; }`', 'How can an `if` statement within a method be used to check if a number is within a certain range (e.g., 0-100) and then assign it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '9eacb988-f58b-494a-ab8f-c5e336824eb0', 'a609a5e8-2dea-43e3-9959-2e8a595ace6f', 'Only the individual or entity it belongs to.', 'If information is ''private'' in the real world, who typically has access to it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '9eacb988-f58b-494a-ab8f-c5e336824eb0', 'd72b148a-dbf4-442d-9816-6d780d010b90', 'Encapsulation', 'Which Object-Oriented Programming concept is achieved by restricting direct external access to an object''s internal state?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'aeb0e446-b9bc-4b30-8c4d-613ebc224f6d', '6a6f511c-c750-45a8-b526-5a4e150fe2a3', 'That data is accurate, consistent, and valid.', 'What does the term ''data integrity'' imply about the quality and reliability of data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '6f6cc360-0752-4cdd-ac2f-cbe201f5c9db', '789bed35-e068-4db9-9f0f-7bd5b56515f8', 'To restrict or control external access to the data.', 'Encapsulation involves bundling data with the methods that operate on that data. What is the goal of this bundling in terms of external access?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '6f6cc360-0752-4cdd-ac2f-cbe201f5c9db', '70c213bf-fdbb-45e3-89e1-f195544d30d6', 'Through its exposed interface (methods).', 'If an object''s internal state is hidden, how do other objects send messages or requests to it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'aeb0e446-b9bc-4b30-8c4d-613ebc224f6d', 'db114af5-0efc-41b5-bba6-435d1ec039d5', 'By controlling all modifications to that data internally.', 'How can a class prevent its internal data from being put into an invalid or inconsistent state by external code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'be10e514-f9ec-46bc-b4ef-18fad43eea8e', '1af4f9ef-24fe-4e7f-a70b-983b38dc8130', 'Using the `private` keyword.', 'How would you declare an attribute in Java so that it''s only accessible within its own class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '665f4941-f8bc-4a30-9e12-a10bfbf95f71', 'cee5f12a-37fa-45fe-b932-20390ed6a390', '`private`', 'Which access modifier would you use if a class member should only be used by the class itself and no other part of the program?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'be10e514-f9ec-46bc-b4ef-18fad43eea8e', '9a2883fb-6e46-420b-b23d-e26d35d4831d', 'Through public methods designed for that purpose (getters and setters).', 'If an attribute is `private`, how can other objects still retrieve or change its value in a controlled manner?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '665f4941-f8bc-4a30-9e12-a10bfbf95f71', '21faa3bb-c7ad-4506-bb4c-b8a6462a231c', '`public`', 'Which access modifier designates methods that serve as the main interaction points for other objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '61de4ab3-c8bf-4c2e-a44f-5aaf389c9dcb', '66eecb33-ae2d-4b5f-915f-0f73f343b47a', 'It could become invalid, inconsistent, or corrupted.', 'What could happen to an object''s internal data if any external code could change it at any time without restriction?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '61de4ab3-c8bf-4c2e-a44f-5aaf389c9dcb', 'ea57f589-53b9-4514-a06f-e6dd69fc10e5', 'They can include validation logic to ensure the new value is acceptable before assigning it.', 'How do setter methods contribute to data integrity even though they modify a private attribute?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '034177ba-c716-4b8b-9aa9-701cc0ce112b', 'b7c2c91e-f89d-4ccd-bf28-9eed72505a32', 'Clarity / Readability', 'What aspect of code quality relates to how easy it is to understand what a class does?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '034177ba-c716-4b8b-9aa9-701cc0ce112b', '2c0e4774-8223-4288-b0a3-9354708b0ea4', 'They often dictate specific rules that must be followed for the code to compile correctly.', 'How do programming language rules, like those in Java, impact class names, especially for compilation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '869c489f-10db-42ae-9162-e3f850680d42', '3852cfee-7ac6-4ea9-9495-cff1a3bfe9d9', 'It ensures everyone understands and can work with the codebase consistently.', 'Why is uniformity in code structure and naming beneficial when multiple developers work on the same project?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'fa909bd7-503d-4a32-80a3-0dfabb66e28c', '59e8a36b-a321-4cf4-aa99-62c22733b94d', 'It provides immediate context and intent.', 'How does a class name directly inform a developer about its role without reading the code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd92a884e-c219-4d88-a84f-8681d8942417', '4fdf3797-d601-42cf-8260-2b18c5fc182b', 'Compilation', 'What is the process that converts Java source code (`.java` files) into bytecode (`.class` files)?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '869c489f-10db-42ae-9162-e3f850680d42', '890b975a-f248-4300-85c7-886a3736f936', 'It leads to confusion, inconsistency, and increased difficulty in understanding and maintaining the code.', 'What happens if individual developers use their own arbitrary naming conventions in a shared project?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd92a884e-c219-4d88-a84f-8681d8942417', '22249c32-f382-4c0f-9c74-76d7ae784929', 'A compilation error', 'What kind of error would typically occur if a `public` Java class name did not match its filename?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'fa909bd7-503d-4a32-80a3-0dfabb66e28c', '0aee71f4-f574-45c2-bff8-7f4a5177d1bd', 'It leads to increased maintenance time and potential errors.', 'What is a common problem in software development if code is difficult to understand?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '25d4205b-69da-4b39-9abb-adfc2dc6b4a0', '9e165afe-4d76-4e4e-a420-9d10a2911fce', 'Internal details / Implementation details', 'What kind of information should typically be hidden within a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '25d4205b-69da-4b39-9abb-adfc2dc6b4a0', '4a52379c-0142-4537-be68-4727a11f399d', 'Only necessary components / Only what is essential', 'What is the core idea of ''minimal'' in this context regarding what a user sees?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '894d1b82-5bdb-41b6-9f4b-d151ed535732', 'eb970980-e35e-4736-a063-74038ef4362c', 'No.', 'Can a method declared as ''private'' be accessed directly from a different class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '894d1b82-5bdb-41b6-9f4b-d151ed535732', 'e089ebae-a346-4aa9-af23-ec1e4f6e09cf', 'A public method.', 'If an external user requests a task from a class that requires internal logic, which type of method does the user call?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e61c5e03-8ab6-4059-8d2c-bdfcc3dcc677', 'dbe7ba57-51a4-47cb-a604-4c04c2ea9e90', 'To hide internal details from the user.', 'What is the primary goal of encapsulation regarding how external class users perceive a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e61c5e03-8ab6-4059-8d2c-bdfcc3dcc677', '09704c22-26c9-45fc-a361-4cc4df98a034', 'It simplifies usage and allows internal changes without affecting external code.', 'Why is it beneficial to restrict the amount of information a user needs to know about a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e99fa713-6d2d-49b8-b4d3-f2cd7b4ab625', 'b967ca73-32a6-485f-8a33-34737b628357', 'It provides its own implementation for an inherited method with the same signature.', 'What does it mean for a subclass to ''override'' a method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e99fa713-6d2d-49b8-b4d3-f2cd7b4ab625', '0fbab180-9cc8-4378-91b0-100d40bd8667', '`Animal` is the common type, `Dog` is a specific type.', 'In the `Animal`/`Dog` example, what is the common type and what are the specific types?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8b0ed57a-7211-4c31-b3ec-d5e15c44f356', '0db39bb8-2b9b-4dc4-bc8a-81643b04d1b9', '```java
class Car {
    public String color = "Blue";
}
```', 'Write a basic Java class named `Car` with a single `public` `String` attribute named `color` and initialize it to "Blue".');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8b0ed57a-7211-4c31-b3ec-d5e15c44f356', '72f8a2be-9769-43d6-b450-93b8fea650c3', '```java
Car myCar = new Car();
```', 'In a `main` method, create an instance of your `Car` class.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (2, '8b0ed57a-7211-4c31-b3ec-d5e15c44f356', '82e7bdb4-92a9-4a2c-a5c1-efe510ae770c', '```java
System.out.println(myCar.color);
```', 'Write the Java code to print the `color` attribute of `myCar` to the console.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '788b54c3-e1cf-4883-b691-3783e5aafc47', '15f5c827-bf23-4ab9-a0fd-de2bf8def297', 'Simple solid line', 'What UML symbol is used for a general relationship where objects can exist independently?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '788b54c3-e1cf-4883-b691-3783e5aafc47', '94739795-92e8-4d1e-9073-788755101649', 'Hollow diamond', 'What UML symbol is used for a "whole-part" relationship where the part can still exist even if the whole is gone?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '55ada1c2-5737-4948-a950-37aa8531ca4b', '161f8b5c-c44d-417c-ab0a-cb8dfb64d362', 'It should evolve / Be iterative', 'Should a class''s public interface be complete from day one, or should it evolve?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '55ada1c2-5737-4948-a950-37aa8531ca4b', '4185c8a2-33c6-4d81-ac1f-bf39c5b824eb', 'When explicitly required / Through user feedback', 'What criterion dictates when new public methods should be added to a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '76fbb78a-6ad3-4901-b3b6-47992175ff8b', '14708e2e-ab6f-4221-9410-366cfdb7ce0c', 'No.', 'If a method is ''hidden from the public interface'', can external users directly call it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '76fbb78a-6ad3-4901-b3b6-47992175ff8b', 'bba0b30c-95c8-4cee-8bf5-c3080053055c', 'To simplify class usage and enhance security by controlling access.', 'What is the purpose of exposing only what external users ''absolutely need''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '98243b86-e221-473a-98c5-c00ae328fe1b', '029bf866-db94-4e70-b91d-6ad6deddb75c', 'Through the other object''s public methods (accessors/setters), not directly.', 'In good Object-Oriented design, how should one object access or modify another object''s internal data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '98243b86-e221-473a-98c5-c00ae328fe1b', '406f0cd0-ea80-49ab-a76a-776bc2c5dff1', 'Highly coupled.', 'What is the term for classes that are highly dependent on one another, where a change in one often requires a change in the other?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '6819a748-cf5b-43b3-826a-97d50a102445', 'effa25f5-d973-482d-a294-5b79548aa770', '```java
class Animal {
    public void makeSound() { /* ... */ }
}
```', 'How would you declare an `Animal` class with a `public void makeSound()` method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '6819a748-cf5b-43b3-826a-97d50a102445', '34062408-8e3b-4431-99e9-398af99b72b5', '```java
class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof!");
    }
}
```', 'How would you create a `Dog` subclass that `extends Animal` and overrides `makeSound()` to print ''Woof!''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8c98acc5-84cc-49d8-912d-ff555fe516ca', '2453d9ea-30cc-4988-a5a8-c71e91ff06c0', 'Encapsulation', 'What is the primary OOP principle that suggests bundling data with the methods that operate on that data and restricting direct access?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8c98acc5-84cc-49d8-912d-ff555fe516ca', '23813822-bb48-40f9-acdf-df5ade01ae14', 'It allows for validation, security checks, or additional logic, and improves data integrity.', 'What is the benefit of controlling access to an attribute through a method rather than allowing direct modification or retrieval?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (2, '8c98acc5-84cc-49d8-912d-ff555fe516ca', 'af76ffd8-b013-4dcd-a6c6-f4ba9aec0bcf', 'The internal implementation of the attribute or its retrieval logic can change without impacting external code that uses the getter.', 'How does this practice contribute to the flexibility of the class''s internal design?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b20e6ce6-92d9-48be-aa48-f3b39ffa0705', 'f8ac551a-af2b-4aba-8bd0-3c83f1f04d5f', 'It simplifies it / Makes it easier to learn', 'How does providing fewer public methods impact the learning curve for developers using the class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b20e6ce6-92d9-48be-aa48-f3b39ffa0705', '8dfd4d0f-93ce-4bbd-aea4-e49260ae558d', 'Security vulnerabilities / Data corruption', 'What risk arises if external classes can directly access or modify sensitive internal data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '4a7a5ce9-66ed-46c0-a816-e8ae9a6ea7ea', 'e2213bf7-8d4e-4319-884a-faa82260fb1b', 'Go to a destination / Take me to the airport.', 'What is an example of a high-level action a passenger would tell a cabbie to do?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '4a7a5ce9-66ed-46c0-a816-e8ae9a6ea7ea', '2bcb1430-68c5-44e6-9b06-6b795675331b', 'Turning the wheel, accelerating, braking, changing gears.', 'What are some low-level, specific actions a cabbie performs to achieve that high-level request?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5fe02d93-b135-4d8e-9c84-f01df5cda967', 'b018f421-56ff-41ce-ae8b-02cd0c257afb', '`extends`', 'What Java keyword is used by a class to inherit from another class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5fe02d93-b135-4d8e-9c84-f01df5cda967', 'f193885c-54da-41bf-ab66-9b999877df07', 'Yes', 'For method overriding, must the method in the subclass have the exact same name and parameters as a method in its superclass?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '44cd4a6c-057f-46f9-8b4c-485a3f90977c', '525f61c1-419e-4b92-8296-bd2b42100fbc', 'Composition', 'What kind of "has-a" relationship implies a strong ownership and dependency, where the part cannot exist without the whole?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '44cd4a6c-057f-46f9-8b4c-485a3f90977c', 'aba7c781-c8c7-4d7e-a0a2-658aea9d6fba', 'Filled diamond', 'Which diamond symbol in UML signifies that the ''part'' is destroyed when the ''whole'' is destroyed?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '67f2465f-458e-448b-8de8-a90c8c09884b', 'add745ba-2824-4a00-a388-9aa882bf393c', 'Over-design / Unnecessary features / Missing critical features', 'What problem might arise if a class designer assumes all user needs without feedback?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '67f2465f-458e-448b-8de8-a90c8c09884b', '08c0ba04-7c6b-4ec3-993e-a685b72138be', 'It validates whether proposed additions are truly needed / Prevents adding unneeded methods', 'How does feedback support the ''minimal'' aspect of interface design?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'dae4ec50-4cec-4d5f-8510-05d28dd1eb5e', '8b2d904f-9098-42ef-aadd-d55177150131', 'Internal operations within the class.', 'Are private methods meant for direct external use or for internal operations within the class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'dae4ec50-4cec-4d5f-8510-05d28dd1eb5e', '20116e44-ec80-4dcf-8392-dd15000065e0', 'To contain or hide details within the class.', 'What does ''encapsulate'' mean in the context of class methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '69ac3d23-f357-46eb-8f3d-bf9a2fd96a0b', 'cd1931c4-0a77-4181-86a1-633310b792d0', 'The interface', 'What part of a class defines how other objects are intended to interact with it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '69ac3d23-f357-46eb-8f3d-bf9a2fd96a0b', '081d664c-6d45-4307-b0d6-fc114fa71f91', 'The user''s code remains unaffected.', 'If a user interacts only with an interface, what is the desired outcome if the hidden internal code changes?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '232827d8-1365-4cf3-9f4e-8bb317b88d2f', '0ec857f2-2b4e-4e63-baf0-ed9b241e44c7', 'It allows common interaction while providing specific behaviour.', 'What is the benefit of having different subclasses respond uniquely to the same method call (e.g., `makeSound()`)?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '232827d8-1365-4cf3-9f4e-8bb317b88d2f', 'd9db8db5-c922-4226-a640-6f26596bea4d', 'Existing code that uses the superclass type can interact with the new subclass without modification.', 'When adding a new type of object (a new subclass), how does overriding the common superclass method help integrate it into existing code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c5349080-b322-4f51-b497-dcb1738dd14a', 'f107b299-53ce-4394-9e01-56faec7da0cc', 'Data', 'What does an object contain in addition to its behaviours?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c5349080-b322-4f51-b497-dcb1738dd14a', '6f9a2ba1-c8f1-47fd-9826-dc8bd5cb1c18', 'Attributes', 'What is the specific OOP term for the data that differentiates one object from another?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'ce667025-d1fe-4ad1-bc40-1171d0560aa8', '32c004d6-d11e-4dd8-b650-61b22104fb26', 'Inheritance', 'What relationship is indicated when one class is a specialised version of another, shown by a solid line with a hollow triangular arrowhead?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'ce667025-d1fe-4ad1-bc40-1171d0560aa8', 'a8ff3e14-4a46-46ca-98fa-fd83670e78af', 'Aggregation', 'Which type of "has-a" relationship is shown by a hollow diamond, implying the part can exist independently?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (2, 'ce667025-d1fe-4ad1-bc40-1171d0560aa8', '8645cb6b-31b2-4ea4-846c-5d67b5ff444e', 'Association', 'What does a simple line connecting two classes in a UML diagram typically signify?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8738dab3-6b5a-436a-ab21-c01ff9d152a4', 'aebcd9b6-8e78-4925-b3b6-2443d2622f7b', 'To define how external users interact with a class.', 'What is the general purpose of a ''public interface'' in object-oriented programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8738dab3-6b5a-436a-ab21-c01ff9d152a4', 'd59b2fb1-cfd2-4137-b6fb-60818b4a9b17', 'It simplifies the class''s usage by reducing the number of exposed elements and potential interactions.', 'How does limiting what external users see affect the complexity of using a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b05e73a0-963f-49ea-9a47-caa551dfc530', 'db124a97-004c-49f8-9ed7-239ff3d17236', 'To maintain data integrity and prevent unpredictable changes.', 'What is the primary purpose of restricting direct access to an object''s internal attributes and methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b05e73a0-963f-49ea-9a47-caa551dfc530', '97ee2338-44ab-4eed-9184-09404b227e91', 'Only the modified implementation needs thorough retesting, not all code that uses the interface.', 'If an implementation changes but the interface does not, how does this simplify the testing process for other parts of the system?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f61ab599-ae39-4ee8-923e-62a23468e185', '2dee676f-0879-4773-943c-9c09561b5c6b', 'Method overriding', 'What concept allows a child class to change the behaviour of a method inherited from its parent class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f61ab599-ae39-4ee8-923e-62a23468e185', '8dfadb8d-ac88-4fe4-a2ea-7c312617cf7d', 'Yes', 'Does method overriding involve the same method signature in both the superclass and subclass?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8e07dd6d-3caa-451d-ba20-63ce996bdeea', '82d58226-0d58-485d-bb5c-85b43453bbba', 'The existing code would automatically call the `Bird`''s specific `makeSound()` without being changed.', 'If you have a collection of `Animal` objects (some are `Dog`, some `Cat`), and you add a `Bird` subclass that overrides `makeSound()`, how would existing code that iterates through the `Animal` collection behave?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8e07dd6d-3caa-451d-ba20-63ce996bdeea', 'a61ca019-686c-4541-815f-14290316b5b3', 'The ability to add new functionality or components without modifying existing, tested code.', 'What does ''extensibility'' mean in terms of adding new features or types to a software system?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5a588477-68c4-4f97-b636-85daa7ce6e62', 'a877dd21-9c0a-44a8-a981-a6ebd48db8e2', 'Data hiding or Encapsulation', 'What concept dictates that an object''s internal data should not be directly exposed?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5a588477-68c4-4f97-b636-85daa7ce6e62', '2787ad16-dc51-40d0-b491-e192ca98339d', 'Getter method or Accessor method', 'What kind of method is specifically designed to allow other objects to *read* a private attribute''s value?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b6fce91c-fb87-4d57-856d-5f57704256a2', 'b463f779-3886-4ecb-af5f-d72868a6eca7', 'Inheritance', 'What is the term for a relationship where one class is a more specific version of another?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b6fce91c-fb87-4d57-856d-5f57704256a2', 'a452a67e-52db-4801-81a2-23923ae05749', '"is-a" relationship', 'Which type of relationship in OOP describes a "subclass is a superclass" scenario?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '251883e1-d851-447c-b986-be4dcab5dcc5', '6e10097b-9134-4d3a-a57d-0204947026a6', '''has-a''', 'What phrase signifies that one object is a component or part of another?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5ea915ba-e221-46be-9b49-8308b5474914', '17d77ca2-3b03-45f0-bb51-d46f95181b27', 'Composition', 'When one object is built from other objects that are essential to its function, what relationship is typically used?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '251883e1-d851-447c-b986-be4dcab5dcc5', '66def22d-3eab-4aff-9882-7c07a8591f6c', 'Declare it as an attribute or member variable.', 'How do you include an instance of one class within another class using code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5ea915ba-e221-46be-9b49-8308b5474914', 'eb5b325f-da1f-4d53-91fa-c964060a08f2', 'No', 'Can a `Car` function as a car without an `Engine`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '623cccb4-d5b4-4c07-bbb3-630c195882cd', 'a2914ce1-1a34-4c6d-8d97-07f72eb30c80', '''has-a'' relationship', 'What kind of relationship does composition primarily represent?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '231e02a7-1000-4323-a5c7-67cd2575e870', '2b4199e7-04c3-440b-a45a-0b67c924bb2d', 'It increases reusability and flexibility.', 'How does composition affect the ability to reuse a component in different contexts?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '623cccb4-d5b4-4c07-bbb3-630c195882cd', 'a05a1493-bca7-405a-b0a0-0bd39f0622d0', 'As member variables or attributes', 'When a class uses composition, where are the ''other'' classes typically stored within it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '231e02a7-1000-4323-a5c7-67cd2575e870', '533e746d-5325-47c6-a4fd-2629d5cadc4f', 'Changes can ripple through and affect all subclasses.', 'What happens in an inheritance hierarchy if a significant change is made to a superclass''s internal implementation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a324b912-609f-41a2-b23b-bf4f57b41f6b', 'd5d3d20c-5903-4977-a65c-a412fdcdd0bc', '`is-a` relationship', 'What kind of relationship is inheritance?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a324b912-609f-41a2-b23b-bf4f57b41f6b', '743e180d-dc12-4c15-91f3-0a59f3dee177', 'Superclass', 'Which class is at the top of an inheritance hierarchy?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'edd8fd58-924f-4435-8f3b-d17bfe66ef90', '573922a3-8a12-42ce-8383-797cd8df2a18', '`extends`', 'What keyword indicates an inheritance relationship in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '551de974-c017-4509-b750-9ca4486c87a1', '948602aa-ff84-4dd6-9b19-d450477dfc39', '`Dog` ''is a'' `Animal`', 'What is the relationship between a `Dog` and an `Animal` if `Dog` inherits from `Animal`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'edd8fd58-924f-4435-8f3b-d17bfe66ef90', 'd3cb1a5e-244b-4bd5-b3f5-c17caf46009a', '`Instrument`', 'Which class is providing functionality to the other class in this example?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '551de974-c017-4509-b750-9ca4486c87a1', '449b9609-218c-4762-9f89-1f3bf29124c2', 'Subclass', 'Which class is considered the ''child'' in an inheritance relationship?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8e02cc12-78ee-4cea-ac09-849fecd1bb0d', 'bd455f63-d5cd-4fab-aa95-d175da2124fe', 'Superclass', 'Which class typically defines the most general characteristics?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8e02cc12-78ee-4cea-ac09-849fecd1bb0d', '487f2341-f565-4e4d-a98f-84683daf24eb', 'Subclass', 'Which class adds more specific details or new functionality?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'bd4f3fc0-16c4-4c85-b70d-f2a8438fb86c', '423d5f75-b5af-4287-bebf-25b379177076', 'It means a block of code can be executed multiple times from different parts of a program without being rewritten.', 'What does ''reusable'' mean in the context of programming code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'bd4f3fc0-16c4-4c85-b70d-f2a8438fb86c', '25537447-6986-443e-9acc-c8936f375514', 'It makes the program easier to understand, debug, and maintain by isolating specific tasks.', 'How does breaking a large program into smaller, distinct functions help manage complexity?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '730403b9-5558-4ed7-9d18-5d9a4cabc6b6', '69e0e474-c1c3-44f6-a619-b5118eebd2f7', 'They are access modifiers and keywords that define how the function can be accessed and whether it belongs to the class or an object.', 'What is the role of `public static` in this function definition?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '754062c6-e890-40c2-8797-da3981b03891', '87275a2c-3357-47d8-ac82-c67fd5fa165b', 'Arguments provide the specific input data that the function will use to perform its task.', 'What is the purpose of passing arguments to a function during invocation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '730403b9-5558-4ed7-9d18-5d9a4cabc6b6', '5da99361-6d46-44a2-b8cb-29c230dfe728', '`return`', 'What keyword is used to send a value back from a function?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '754062c6-e890-40c2-8797-da3981b03891', '99dda55e-210d-4419-8934-d328bcf116c8', 'The parentheses would be empty, like `functionName()`.', 'If a function does not require any input, what would its parentheses look like during invocation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '309ea252-d17c-403f-92d2-c2463b94ef45', 'c914670d-6ee1-4c63-b69d-c2c0a1c9c0db', 'An integer (`int`).', 'What is the return type of a function that calculates the absolute value of an integer?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '309ea252-d17c-403f-92d2-c2463b94ef45', 'b5f8191e-533c-497a-bbd0-21112c813711', '`int result = getAbsoluteValue(someNumber);`', 'How would you call the `getAbsoluteValue` function and store its result in a variable named `result`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '470e26d0-b23a-4e17-8832-e3fe831f1101', '05da8e6e-c47e-418c-a51b-50b53a522bfb', 'The region of a program where a declared name is valid and can be referenced.', 'What does ''scope'' mean in programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '470e26d0-b23a-4e17-8832-e3fe831f1101', 'eb2920b5-cea7-4d16-a742-33a33189fa8e', 'A global variable.', 'If a variable is declared at the top of a file, outside all functions, what type of variable is it likely to be?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '055064e7-0ec4-47ef-843d-52d3caa042d9', '33d119b5-3043-4262-912a-b03453de97b5', 'Through its parameters.', 'If a function needs specific information to perform its calculation, how does it typically receive that information?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '055064e7-0ec4-47ef-843d-52d3caa042d9', 'f3228308-b8e8-4dfa-826d-2dfd5c87def4', 'It improves control over data, reduces unintended side effects, and makes functions more modular.', 'What is the benefit of passing data explicitly instead of accessing it globally?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c8bee84d-ebc6-4abb-8b4f-f38a2d2eb398', '380964bf-8731-4b4d-84a6-3c3a7c77ce00', 'It is a local variable to `modifyValue`.', 'What is the scope of `inputVar` in the `modifyValue` function?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c854590d-1141-42be-90b8-47a91d59afe5', 'bf2918b5-2158-4d0a-9f8d-77280d46ca5d', 'It becomes difficult to trace the flow of data and pinpoint where an incorrect value might originate.', 'If many functions can change a variable, what challenge does that create for a programmer trying to understand the program''s behavior?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c854590d-1141-42be-90b8-47a91d59afe5', 'c618e7a1-d449-43d1-8440-393e06e248e4', 'It refers to an alteration of the system state that is observable outside the called function, often unintended or undocumented.', 'What does ''side effect'' mean in programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '08b82dca-6f46-4031-ae2d-cdd78ff09208', '54089bec-89b0-42b6-8212-64957bb92a07', 'A sequence of instructions or operations.', 'What is the primary characteristic of a ''procedure'' in programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '08b82dca-6f46-4031-ae2d-cdd78ff09208', '0e7e50fc-43f9-489c-bf23-9a910ae8f11e', 'Data is often global and easily modified by various procedures.', 'How does procedural programming typically handle global data access?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0b3be419-77cf-4989-af13-efa2987a79f9', '7a3eff40-b4c0-458c-9d80-ccc80f1702a0', 'In procedural programming, data and operations are separated; in OOP, they are combined in objects.', 'What is the fundamental difference in how data and behaviors are handled in procedural versus object-oriented programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '0b3be419-77cf-4989-af13-efa2987a79f9', 'c75275be-42ff-4442-8a23-63a2ec044017', 'Global data means it can be accessed and modified from anywhere, leading to potential unpredictability.', 'How does the concept of ''global data'' relate to data access in procedural programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c8bee84d-ebc6-4abb-8b4f-f38a2d2eb398', '5d9116e5-ed2c-4010-9f20-e6c2916714dc', 'A copy is created and passed to the function, so the original variable is not modified.', 'In Java, when a primitive type (like `int`) is passed as a parameter, is the original variable modified or is a copy created?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c6da3044-b2e9-4480-87f5-c150f9545467', '4737c8a9-e73a-4608-98d6-f00e93aac1b8', 'The function only relies on the data it receives through its parameters, not external state.', 'How does parameter passing make a function more self-contained?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c6da3044-b2e9-4480-87f5-c150f9545467', '8c9dc122-6e87-4330-9b6a-6dfa50a7cafa', 'It makes it very difficult to pinpoint the source of errors or unexpected behavior, as many parts of the code could be responsible.', 'Why is uncontrolled modification of data a problem in large programs?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (2, 'c6da3044-b2e9-4480-87f5-c150f9545467', 'ddeb8207-7e29-4828-833b-b6a447a8f140', 'It means that any function can change the global variable''s value at any time, making its state hard to track and leading to unexpected behavior.', 'What does ''uncontrolled and unpredictable'' access to data refer to, in the context of global variables?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '42d721b7-52d0-4bdd-a356-d5a0218cc5cd', '9a839491-e57e-49e5-b5d6-78eb4578efbc', 'Sequence, conditions, and iterations.', 'What are the three basic constructs often associated with structured programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3db7efa0-4a2a-48bb-8db1-a5cef534a60c', '42f8d1fb-973c-44c9-a84a-54ed7bee2e30', 'It means the data is accessible from anywhere in the program, not just within a specific function.', 'What does it mean for data to be ''global'' in a program''s scope?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '42d721b7-52d0-4bdd-a356-d5a0218cc5cd', '56a98d32-082f-4a5b-a41a-c345e250e36a', 'Control flow and repetition of operations.', 'Does a `for` loop primarily define data or control flow?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3db7efa0-4a2a-48bb-8db1-a5cef534a60c', '10e8b8f8-e6ae-48d3-b13d-852b7054be05', 'It can lead to unpredictable changes and make debugging difficult.', 'How does uncontrolled access to data affect a program''s reliability and predictability?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'fcd44ed1-4891-4261-a81b-2b15e73b9cd1', 'e384eba9-ff10-4a5f-a6cd-04f4502c9525', 'It can be easily modified by external code, making it unpredictable.', 'In procedural programming, what is a consequence of data being separated from functions and being globally accessible?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'fcd44ed1-4891-4261-a81b-2b15e73b9cd1', '6023402e-8e38-4a76-b33b-2002636d8982', 'Encapsulation.', 'What object-oriented principle combines data and its manipulating functions into a single unit?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '70e7ec3d-fd9c-40db-b124-8bb514e395c6', '8cff7550-2c20-4d51-b62b-d18dd3432d57', 'Data is often separated into distinct structures or held globally, apart from functions.', 'In procedural programming, where is data typically stored in relation to the code that processes it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '70e7ec3d-fd9c-40db-b124-8bb514e395c6', '347e1557-db34-426b-aaed-45c193144ff8', 'Encapsulation.', 'What concept in OOP involves bundling data and the methods that operate on that data into a single unit?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5054929b-6006-4469-851a-83ed99b73024', '56c78c4d-e8ca-4d5d-91ab-f2448ab7d61e', '`private`', 'What keyword is typically used in Java to hide attributes from direct external access within a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd727fb5a-5aa3-447a-a256-45f62f356f59', '840f02b3-d7b9-40d0-b3fe-d6becaecf294', 'Data can often be global and easily modified by any part of the program, leading to uncontrolled access.', 'What is a common problem with data access in procedural programming when data is not explicitly tied to specific functions?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5054929b-6006-4469-851a-83ed99b73024', '56c1b5e5-e256-423b-a4e1-11200dfd28df', 'Accessor methods (getters and setters).', 'What types of methods are commonly used to provide controlled access to private attributes?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd727fb5a-5aa3-447a-a256-45f62f356f59', 'cff17d9b-372c-443e-9912-e1f2604d651b', 'It restricts direct external access, allowing modifications only through defined methods (getters/setters).', 'How does bundling data and its operations within an object help control access to that data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '1cbef223-4c02-4664-98cf-90fe1489efd9', 'aaa4fd9c-992e-4ee9-af66-7e488edbabd3', 'The Single Responsibility Principle (SRP).', 'If a class has multiple methods that handle different aspects of a system (e.g., calculations and output formatting), what OOP principle might it be violating?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '29ffb430-c86d-4925-9382-1f7cc5f5663d', 'd16b9276-7e69-4331-b17c-3ae3f4c11dc7', 'Uncontrolled data access, difficulty in testing, and complex debugging.', 'What issues arise in large procedural systems due to data being separate from the functions that operate on it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '1cbef223-4c02-4664-98cf-90fe1489efd9', '24edff67-6edc-4e53-9a04-e21995220078', 'It makes the class easier to understand, test, and maintain, as it has only one reason to change.', 'What is the primary benefit of designing classes with a single responsibility?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '29ffb430-c86d-4925-9382-1f7cc5f5663d', 'aa0cce9a-94be-4c44-8a0a-70f9c3b0b533', 'It creates self-contained, modular units that control their own data and interactions, simplifying overall system management.', 'How does OOP''s concept of an ''object'' (containing both data and behavior) mitigate these issues in complex systems?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5312c739-2cae-4c6a-978f-3634c3105920', 'f0c80149-b8f1-485a-a4e5-d47959330898', 'The data would be separate from, and often passed into, the function.', 'In procedural programming, if you have employee data and a payroll calculation function, where would the data reside relative to the function?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5312c739-2cae-4c6a-978f-3634c3105920', '51634afd-9d6e-4a9e-b8a0-c8107009c037', 'They would all be encapsulated within an `Employee` class.', 'In OOP, where would the `hoursWorked`, `hourlyRate`, and `calculatePay()` logic for an employee typically reside?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd5c9571a-9707-4d05-8367-5e6bb8ec7719', '6040836b-a4a8-489d-bc11-2280b3c72d4b', 'A blueprint or architectural plan.', 'If you wanted to build multiple houses that all have the same basic design, what would you use first?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd5c9571a-9707-4d05-8367-5e6bb8ec7719', 'b1555268-18a1-4bd5-bc6b-388904983f4e', 'A class.', 'What defines the common attributes and methods for a group of related objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3b35054e-7697-46f7-9301-ac5691b66c3a', 'a1547cdf-7aee-48ea-b6e4-7c196f3c16d7', 'Attributes and methods.', 'What key elements (like data and actions) does a class define for objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3b35054e-7697-46f7-9301-ac5691b66c3a', 'e604003d-a597-458e-95b9-dbae13ea34f8', '```java
class Car {
    String color;
}
```', 'Write a basic Java class definition for a `Car` with a `color` attribute.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '123297ed-89d4-43dd-affc-3abecee73495', '017b0c95-1353-40f9-9a74-4ec3448b0ab9', 'It allows all student-related data and actions to be defined in one place and reused for each individual student object.', 'How does defining a class for a ''Student'' help you manage many students in your program?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c4604a3f-2f58-4b67-9861-fa794e41648e', '8ad29a39-a56d-4be2-8f00-9e0023867027', '`class`', 'What is the primary keyword used in Java to define a new class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c4604a3f-2f58-4b67-9861-fa794e41648e', '33b9c242-e9b9-4fa2-907b-df224e011046', '`{}` (curly braces)', 'What symbols are used to define the scope or body of a class in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '123297ed-89d4-43dd-affc-3abecee73495', '81a6c355-79d5-42be-9466-a172a5e590ad', 'You would have to change the code in every place that behavior is implemented, leading to duplication and potential errors.', 'What happens if you need to change a shared behavior across multiple ''Car'' objects if there''s no class defined?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '641d22e9-e90b-45b9-9d56-6a9f070ff803', 'e37ccea3-1522-497f-8e7b-83e52d61bd8e', 'Data or properties.', 'What part of an object holds its distinct characteristics, like colour or size?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '641d22e9-e90b-45b9-9d56-6a9f070ff803', 'b2d05896-29d4-4cbf-93c0-c86bc0e87e88', 'Attributes (or data members).', 'What is the common term for these data points in Object-Oriented Programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5988473a-c9b8-4bcc-bd43-e63330582112', 'd3ca3365-f56b-47d9-9d1a-6cf566d01c3b', 'To store information or characteristics about an object.', 'What is the primary purpose of data members in a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '7b000bc3-6a3a-4fe4-80d1-96340d071514', '8ee99bc0-effe-49fb-96f4-fa83cf1c7780', '`__init__`.', 'In Python, what special method is automatically called when a new object is created from a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5988473a-c9b8-4bcc-bd43-e63330582112', '751f1fa7-f7c6-423c-83f8-b52ac7af3abf', 'Each object created from the class will have its own distinct values for these data members.', 'How does this information change from one object to another if they are from the same class blueprint?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '07966f05-f013-4dbd-9fe8-b41160502f18', '43230963-5837-43ee-ba23-5e0e2742b02d', 'Its unique data values or characteristics.', 'What makes one instance of a class different from another instance of the same class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '7b000bc3-6a3a-4fe4-80d1-96340d071514', '13535417-4eba-497f-b805-0fba2b5f5dff', '`self.attribute_name`.', 'How do you refer to the current instance of a class within its methods in Python to assign values to its properties?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e0b91709-8c8d-4396-8aae-1aec1b66fdd7', '309b8576-8c41-407a-9078-2ec1856735a0', 'Inheritance', 'What concept allows a class to acquire properties and behaviours from another class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '07966f05-f013-4dbd-9fe8-b41160502f18', '4394f600-446b-4510-8e5d-038950559b3d', 'Through its defined attributes.', 'How does an object ''remember'' its current specific characteristics or conditions?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'db7a1347-ee38-4496-bc72-e4b2ade0802a', '35bd0f0c-be9a-4835-8028-90de85efa70a', 'A class.', 'What concept in OOP acts like a cookie cutter?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'db7a1347-ee38-4496-bc72-e4b2ade0802a', 'b20dd47f-1532-4db8-9c2a-229003861518', 'Its shape and characteristics (a template).', 'What does a cookie cutter define for the cookies it produces?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '4a5fa5c3-abf0-4c04-817f-232c1d3783c0', '3178028a-ec24-4b37-a68f-c0499462a3b3', 'A class.', 'What defines the *characteristics* and *actions* common to a category of things?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '4a5fa5c3-abf0-4c04-817f-232c1d3783c0', '3aa2304b-89e6-4a9a-a0bf-0707acf516ec', 'An object.', 'What is a *specific realization* of that category, with unique values for its characteristics?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '991d1199-22ac-4eae-8e19-ae8239fd40c6', '3627cccf-4f55-47b8-af75-ab4534142508', 'An object or instance.', 'If a class is a blueprint, what is the actual item built from that blueprint?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '991d1199-22ac-4eae-8e19-ae8239fd40c6', 'a41b7a66-9230-49eb-910a-f573c399b465', 'An object has its own unique data.', 'Does an object have its own unique data, or does it share data with all other objects of the same type?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'bfd15738-1c67-4904-af32-5847677740ee', 'a708fcf5-1e58-4f50-9653-616f09c82335', 'It allows for code reuse and consistency.', 'How does defining a class once (a blueprint) help with creating many similar but distinct items?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'bfd15738-1c67-4904-af32-5847677740ee', '8fdffc3e-8ee0-458a-a7d9-5cd7efb601a1', 'Its own specific data (state/attributes).', 'What does each individual object manage that makes it unique from other objects of the same class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c8a305aa-31e5-491e-a959-134250d5b766', '8621a8db-1d5d-4fe9-86f7-10d3be7018a0', 'Behaviors or actions.', 'What do methods represent within a class definition?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c8a305aa-31e5-491e-a959-134250d5b766', '020ae906-e7d9-4452-b0dc-ddb1947fe7d0', 'The object performs that specific action.', 'What happens when you ''call'' one of these behaviors on a specific object?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f7459686-8887-423d-ae3d-a62fda75aed3', '2b83f9ed-57f0-4363-a545-d5124875ca74', '`homeAlarm`', 'How do you refer to the specific object you want to interact with?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0f221384-6792-4873-a41e-bcbfcbcc3bab', 'dd6d5c2e-9df4-4462-8024-94eaf66327f6', 'You tell the object directly to perform that action.', 'If an object is like a ''thing'', and methods are ''actions'' it can do, how do you make the ''thing'' do an ''action''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '50415c83-29fd-4fcf-b5b7-0b79a5e981f1', '756a3e53-6926-4825-9fe6-cd080ae039a2', 'By its object name (e.g., `myLight`).', 'How do you refer to a specific object that you want to interact with?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '0f221384-6792-4873-a41e-bcbfcbcc3bab', '7ee51ac7-98c3-4af4-97ae-5806ed735ead', 'The dot operator (`.`) followed by the method name and parentheses `()`. ', 'In Java, what syntax connects an object''s name to its method''s name?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f7459686-8887-423d-ae3d-a62fda75aed3', '105df0f1-c943-431d-ad47-2966a667778f', '`.activateSensor("FrontDoor");`', 'What syntax is used to call the `activateSensor` method on that object, and how do you pass the `"FrontDoor"` string as an argument?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '50415c83-29fd-4fcf-b5b7-0b79a5e981f1', 'd457e7b5-419f-4e22-923f-57b3e257890a', 'Parentheses `()`, even if no arguments are passed.', 'What punctuation marks are always used immediately after a method name when you are calling or invoking it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '084f878a-7169-4b31-b2e6-01cef6130a4c', '87ffabbc-ea0e-4c35-be96-c8e57ab3545c', 'To prevent direct external access to an object''s internal state.', 'What is the main idea behind data hiding in object-oriented programming?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '748d25c9-32a2-4d0e-80d3-c0ecd4f2bea1', 'cdd82edf-4498-4c6f-9f7c-dd77901c288a', 'Direct modification bypasses control logic and can lead to data inconsistency or invalid states.', 'Why should an external object not directly modify a `private` attribute like `balance`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '084f878a-7169-4b31-b2e6-01cef6130a4c', '6ba919de-c256-4fd5-9f23-21a53e708306', '`private`', 'Which access modifier enforces the strictest level of data hiding, making members invisible outside their defining class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '748d25c9-32a2-4d0e-80d3-c0ecd4f2bea1', '91010f62-4518-4ce8-bd7c-39a0cbb6100a', 'A ''setter'' or ''mutator'' method.', 'What kind of public method is typically used to change the state of a `private` attribute in a controlled manner?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8fd4e29c-a7ab-49a4-a824-73388a5437e1', 'dd7e6212-d6a9-4d36-86a9-68c24e6e81a0', 'They act as controlled entry points for reading or writing data.', 'What is the role of public methods (getters/setters) in controlling data access?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8fd4e29c-a7ab-49a4-a824-73388a5437e1', 'b5e278e6-6d78-46cb-a556-693a46744c3c', 'Because external code only interacts with stable public methods, not the internal structure, thus changes are localized.', 'If internal data structures change, why is an encapsulated class easier to maintain than one with public fields?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '8be897a9-f1af-4b6a-a2d5-a89d3600fa12', 'd6198260-cf12-43e7-977b-8fb3b72c1745', '`private int grade;`', 'How would you declare the `grade` variable so it cannot be directly accessed from outside the `Student` class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b4483529-0e67-44cb-aaf4-6188838ffc87', '4368c5c4-b458-4249-b5a3-02f6494b3c04', 'Validation for valid ranges, format, or specific business rules.', 'What kind of rules or checks might a class want to enforce when a data attribute (like `price`) is modified?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '8be897a9-f1af-4b6a-a2d5-a89d3600fa12', 'b1319c77-373f-4020-9962-8f6a208b2f4f', 'Use an `if` statement or conditional logic within the public setter method to check the input value before assigning it.', 'How do you add logic to ensure the `grade` is within a valid range (0-100) when it''s being set?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b4483529-0e67-44cb-aaf4-6188838ffc87', 'ac81850d-3e9c-449c-8940-b71dd6c40f49', 'It becomes hard to pinpoint *which* specific piece of code made the incorrect change, as there is no single control point.', 'If many different parts of a large system can directly change a `public` variable, what makes it difficult to fix a bug related to that variable''s value?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '1ba54d58-cac1-4184-b94b-c06dc6b28210', 'b8e3227d-da7d-4b90-8163-65671416ec7e', 'It means the method has no implementation.', 'What does ''abstract'' mean when applied to a method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '1ba54d58-cac1-4184-b94b-c06dc6b28210', '3773242a-a55a-4232-ad06-9850ba98eb71', 'No, an interface specifies only method signatures.', 'Can an interface specify any code body for its methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd1548300-b2e3-4ebd-81b6-90b5fa8a1bd1', '8b79215f-b89d-411c-95db-c7fb670ec7f8', '`extends`', 'What Java keyword is used for a class to inherit from another class (abstract or concrete)?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd1548300-b2e3-4ebd-81b6-90b5fa8a1bd1', '7fc2adbd-ad11-4914-823a-c2fa8d01da2c', '`implements`', 'What Java keyword is used for a class to adopt the contract of an interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a8aa6b6b-3b3a-402e-8e43-3e3442a4726f', '1c8f6a80-bb2f-4f0c-a667-e517e0c6edcd', '''is-a'' relationship', 'What kind of relationship does ''inheritance'' typically represent?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a8aa6b6b-3b3a-402e-8e43-3e3442a4726f', '3cf4f576-de59-4af1-902a-dbf4a768d7b5', '''behaves-like-a'' or ''has-a-capability'' relationship', 'What kind of relationship can an interface represent, allowing different types to conform to a common behaviour?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '35a0b16b-7fad-4c90-ba92-8bf155a529fc', '9979f98d-998b-468a-9ade-e84b88e100b5', 'Different objects responding to the same method call in their own ways.', 'What is the core concept of polymorphism?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '833a3045-a4d6-4c02-8f2e-0f6c26dae31a', '0e3d6f1e-9ef1-4406-9972-551a2b8960d6', 'An abstract method within an abstract class.', 'Consider a hierarchy of animals where all animals have a common ''eat'' method, but different ''makeNoise'' methods. Which concept fits defining ''makeNoise'' when some animals also have common (implemented) methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '35a0b16b-7fad-4c90-ba92-8bf155a529fc', 'cefdce2c-9e6a-4857-bb54-8ebbc82dfb4d', 'They define the method as abstract or part of their contract.', 'How do interfaces and abstract classes ensure that different classes have a common method signature?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '833a3045-a4d6-4c02-8f2e-0f6c26dae31a', '37a03cda-5bd5-4fb6-87d6-1bdc3a76f2b0', 'An interface, such as `Communicatable`.', 'If both a `Robot` and a `Human` need to be able to `Communicate`, but they are otherwise unrelated in their core classification, what is the best way to define this `Communicate` behaviour?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c15717c4-7451-4bca-84e4-254ecf57f785', '1c271f5f-5684-475a-a33c-bf5ec610acb7', 'That components have minimal dependencies on each other, allowing for independent changes.', 'What does ''loose coupling'' mean in software design?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c15717c4-7451-4bca-84e4-254ecf57f785', 'cb7630e8-7a71-4b92-a452-a4e210b928ce', 'All subclasses that inherit that concrete method might be affected.', 'What happens if a concrete method in an abstract class is modified?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'e030ecb9-d2ae-43d6-8243-f6730a1aed24', '9d0ff3c6-95d8-48e1-8813-e960dc4193dd', 'Encapsulation', 'Which concept combines an object''s data (attributes) and its operations (methods) into a single package?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '01f03e7f-da6e-4fa9-8159-a1fea5aaedf7', '7572b52f-ae8a-4a0c-80e8-7412aec1098d', 'Internal attributes or implementation details', 'What does encapsulation hide from outside objects regarding an object''s data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e030ecb9-d2ae-43d6-8243-f6730a1aed24', '4944efd3-dde9-40a3-be47-fa4fcb6aba2d', 'Data hiding', 'What is the term for restricting direct external access to an object''s internal data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'bfdd8e8f-85c3-488b-81b9-8615e8433fd2', 'e383215c-2170-4487-a16f-d7dfcd9cc059', 'Hiding implementation details', 'What aspect of encapsulation allows an object''s internal workings to be changed without affecting other objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '01f03e7f-da6e-4fa9-8159-a1fea5aaedf7', '6f78b6ab-3184-4729-8ff1-8d5e7919277f', 'Public methods, such as getters and setters (accessor/mutator methods)', 'What mechanisms are typically used to provide controlled access to an object''s private data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'bfdd8e8f-85c3-488b-81b9-8615e8433fd2', '1816fc04-6ed6-41d2-8e4c-3c4aa6ebdd46', 'Maintainability or Modularity', 'If a class''s internal logic can change without breaking client code, what kind of system quality is improved?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '57707cb3-aee9-40a9-92f7-da8262a2b142', '87ae1969-0d55-45a5-8638-31d55e726141', '```java
public class Item {
    private String itemName;
}
```', 'Define a Java class with a private attribute, for example, `private String itemName;`');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '57707cb3-aee9-40a9-92f7-da8262a2b142', '68fc984c-d422-4300-a8b4-6c5a8fd3f441', '```java
public class Item {
    private String itemName;

    public String getItemName() {
        return this.itemName;
    }
}
```', 'Add a public method to this class that allows other objects to retrieve the value of the private attribute, like `public String getItemName() { return this.itemName; }`');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '7b6d54b5-fa55-4382-be72-f747bad7417e', 'dfdc5965-e464-4001-bbfd-7390261ee890', 'The `Computer` class would declare a `private Processor processor;` attribute.', 'Define two simple classes, for example, `Computer` and `Processor`. How would `Computer` include `Processor`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '7b6d54b5-fa55-4382-be72-f747bad7417e', '02d0c4b0-74e1-4000-a2bc-09928fc4271c', 'The `Computer` class would generally not need to change, promoting independent development and maintenance.', 'If the `Processor` class were updated, how would this impact the `Computer` class if a ''has-a'' relationship is used?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '62e80cc5-e273-4dc2-8003-48cd4998e516', '1aec5c47-6c8b-43fb-9c68-436686b6dbac', 'The program might crash.', 'What happens if an unexpected event occurs and is not handled?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '62e80cc5-e273-4dc2-8003-48cd4998e516', '0f109ba1-2abc-4fdf-9dea-4e8da6f34af8', 'It can recover or terminate safely.', 'What does ''graceful'' handling mean for a program''s operation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5de24cd6-0cc8-4243-bbf7-a8ce782489a2', '1c54d57c-b16f-4653-a34f-6ccb40864cd2', 'Share a reference to one list.', 'If two objects need to modify the same list, should they each have their own copy of the list or share a reference to one list?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5de24cd6-0cc8-4243-bbf7-a8ce782489a2', '7fbdf6f6-3784-4f12-92e3-b2f1c934f35d', 'Shallow copy.', 'Which copying method results in the original and copied object having references to the same nested objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c02a0102-0ca0-47fc-bab7-624e8399194f', '0a81bde8-4377-4950-9279-d681d120210a', 'An unstable or undefined state', 'What kind of state might an object be in if it''s not set up immediately upon creation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c02a0102-0ca0-47fc-bab7-624e8399194f', '8901b18f-f87c-496c-bf7e-0d19dc012f04', 'To prevent errors or unpredictable behaviour when the object is used.', 'Why is it important for an object''s essential data to have values from the beginning?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '744685e6-7137-4b21-863d-11ae6a0a0c9b', 'ec3a3346-4f94-465c-9d92-d98e3b624163', 'Self-contained nature or independence (modularity)', 'What characteristic of an object does encapsulation promote by bundling data and methods?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '744685e6-7137-4b21-863d-11ae6a0a0c9b', '26217cfe-fec9-4914-9fe5-d4faf4806ab3', 'The problem is confined to that specific class, reducing the search area for the bug.', 'If an internal bug is found in a class that uses encapsulation, why is it easier to fix compared to a system without encapsulation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '85659db5-9f04-4f40-abfb-88d79ee46520', 'fe48c67c-e1bc-4691-8e26-c9aade841743', 'Inheritance', 'What concept in OOP allows a class to extend the functionality of another class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '85659db5-9f04-4f40-abfb-88d79ee46520', 'e12e3ee8-9c72-4f58-acbf-ae4849b5e4d9', 'Composition', 'What concept allows building complex objects by combining simpler, independent objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '68b87841-9f59-414c-942c-446ff38b225b', 'f8f2a3a6-349a-40f9-8c3e-b024c5ada8d3', 'Division by zero.', 'What common operation might lead to an `ArithmeticException`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '68b87841-9f59-414c-942c-446ff38b225b', '7fe8283f-263d-4108-bc8b-43504695802c', 'To monitor for exceptions that might occur.', 'What is the purpose of placing code inside a `try` block?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '747b45af-0497-4668-95ac-9c135897bc3f', '6a26dd81-9ee8-4d2a-a139-4a6afad3fac8', 'They share the nested objects.', 'In a shallow copy, do the original and the new object share nested objects or create new ones?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '747b45af-0497-4668-95ac-9c135897bc3f', 'cdb1f31f-6af3-4b26-9d27-d03e8ad9eae3', 'The modification will be reflected when accessed through either of the two objects.', 'If two objects share a nested object, what happens if one modifies that shared nested object?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'aa9b7096-b66e-4333-a985-499c564b034f', '5adf1e97-a2c2-442a-bac9-9da6a433d03a', '`new`', 'What Java keyword is used to allocate memory and instantiate an object?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'aa9b7096-b66e-4333-a985-499c564b034f', '4b298df9-d129-4f8c-96c9-60941cbe5a19', 'Initialisation', 'What process immediately follows memory allocation to prepare the object for use?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f06dfa92-fc5a-4a8f-8b50-045720cf54ce', '192b8396-0072-4c52-81b0-d84d36da0bbd', 'Composition', 'What concept describes building complex objects using instances of other objects as components?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f06dfa92-fc5a-4a8f-8b50-045720cf54ce', 'dbf4af40-5e78-406d-b391-c3bd91e684c5', 'The `Book` class would have an attribute of type `Page` (or a collection of `Page` objects).', 'If a `Book` contains `Page` objects, how is this relationship typically represented in code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'cc00c356-dbee-4e3f-9cb0-b44eda2e3e4b', '243ef2a2-bc75-4ae5-9b80-79ac7b7378a2', 'It is unforeseen.', 'Does a program always anticipate an exception, or is it unforeseen?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'cc00c356-dbee-4e3f-9cb0-b44eda2e3e4b', 'babaea3c-f72b-4a7f-897e-9ff0064482da', 'During execution.', 'When does an exception occur: during compilation or execution?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '6410632f-390a-4cc6-8a86-ebdc4aa42ec8', 'ef6e0855-4710-4683-94c6-7e5a1b49da8a', '`B` (the same object as `A`)', 'If an object `A` contains a reference to object `B`, and you make a shallow copy of `A` to `A''`, what does `A''` reference?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '6410632f-390a-4cc6-8a86-ebdc4aa42ec8', '6e103ae5-f693-40ae-a5b6-5d8be2464c84', 'Primitives are copied by value; objects may involve copying references.', 'What is the primary difference between copying a primitive type (like `int`) and copying an object that contains other objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '697a8302-de94-48d7-acd2-9e6194b8a514', '24868209-7310-4cc5-b48b-1d43fca5d71f', 'Behavioral inheritance.', 'What kind of inheritance focuses purely on ''what an object can do'' rather than ''what an object is''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '697a8302-de94-48d7-acd2-9e6194b8a514', '8f8ea9f1-a003-4ed6-b81f-6e9315d54cd8', 'An interface.', 'What programming element defines a set of methods that a class *must* implement, without providing any implementation itself?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'e0b91709-8c8d-4396-8aae-1aec1b66fdd7', '9635027c-6f59-4943-bd89-2620539d52e0', '''Is-a'' relationship', 'If a `Square` is a type of `Shape`, what kind of relationship does this represent?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '2b12a446-4220-4cfc-b4de-debe9ba0350a', 'ba30fec9-1888-4f28-9817-6e03190586c7', 'Manage them.', 'Do `try/catch/throw` blocks make errors disappear, or manage them?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '2b12a446-4220-4cfc-b4de-debe9ba0350a', '9bd3dbc4-0488-460c-927e-d9b7cb2560bb', 'A program crash.', 'What is a common undesirable outcome of unhandled runtime errors?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f5ce9e9d-dbe5-41fc-8a8e-bc12474bb54f', 'b7f04208-3619-479e-bc80-0599c19d7514', 'It combines features from all of them.', 'What happens when a class inherits from many sources?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f5ce9e9d-dbe5-41fc-8a8e-bc12474bb54f', '369707a3-2405-47d4-8cc0-3531f944d171', 'It can create ambiguity or conflicts between inherited elements, such as methods with the same name but different implementations.', 'Why might combining features from many sources lead to problems?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'f9d89576-54c8-47f1-9d8d-2333734b65f8', 'bfe68413-0eaf-4ec5-aa96-76fa559e403d', 'It can lead to a rigid design that is difficult to change or extend without unintended side effects.', 'What happens if a design incorrectly uses inheritance where composition is more appropriate, or vice versa, in terms of system rigidity?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'f9d89576-54c8-47f1-9d8d-2333734b65f8', '0e2b7242-90cf-4729-98dc-27ba9251063f', 'It simplifies debugging and maintenance by making the flow of data and control more predictable and encapsulated.', 'How does clear object relationship impact the ease of debugging and updating a system?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'cb717fe1-74c8-4971-b740-d2d652dd1c41', 'ec0d24a7-0695-43b7-8df5-e29c0bbe27f9', '`try`', 'What keyword is used to enclose code that might cause an exception?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'cb717fe1-74c8-4971-b740-d2d652dd1c41', '7012491f-992c-490d-a80e-a1afdb988020', 'A `catch` block.', 'If an exception is ''thrown'', what block ''catches'' it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a2f68fad-3ac8-4993-bc77-0609d22b32c0', 'c33441cc-e62e-463c-853c-e6b339108d44', 'They are new, independent instances.', 'What is the state of nested objects after a deep copy relative to the original?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a2f68fad-3ac8-4993-bc77-0609d22b32c0', 'ad889ca8-5ca4-46dc-ae29-a40f20cad991', 'Deep copy.', 'If changes to a copied object should never impact the original object, which copying method is preferred?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '41aeda21-168e-4dd7-97c3-f0491ac8a384', 'bc0f3678-66ed-4d6d-b51d-236ea205994f', 'Null pointer exceptions or unexpected program behaviour.', 'What kind of issues might arise if an object''s variables are not given a default value?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '41aeda21-168e-4dd7-97c3-f0491ac8a384', '54b36659-5b79-4b2a-adef-24004280893d', 'It ensures that the object starts in a predictable and valid configuration.', 'How does setting initial values make an object ''stable''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '86dde6ab-12aa-401c-b92d-83160d21be07', 'c231c124-ba60-4a97-a0ed-954e5f501c14', 'Java.', 'Can you recall a language popular for web or Android development that does not support multiple inheritance?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '86dde6ab-12aa-401c-b92d-83160d21be07', '41b687c1-7c1f-453a-a304-988026c3f8d2', 'Swift.', 'Can you recall a language often used for Apple''s iOS development that does not support multiple inheritance?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3ce63e14-c932-4217-8575-a147a6586eeb', '20dd95a0-d5ad-44a1-9ca9-11741a6b1336', 'Division by zero.', 'What operation typically causes an `ArithmeticException`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3ce63e14-c932-4217-8575-a147a6586eeb', '67493614-8093-4dfb-963c-c2354d28d066', 'By providing the exception class in the `catch` block''s parentheses, e.g., `catch (ArithmeticException e)`.', 'How do you specify the type of exception a `catch` block will handle?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '7f2522d7-5624-4cc9-a650-fa3658c925b0', '00cb0a4b-3cd8-4b33-ae6b-f97da5be8040', 'A new copy of `Y`, say `Y''`, is created, and `X''` references `Y''`.', 'If an object `X` has a reference to object `Y`, and you perform a deep copy of `X` to `X''`, what happens to `Y`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '7f2522d7-5624-4cc9-a650-fa3658c925b0', 'b9337322-705e-45a2-95e4-c747bb86f6c9', 'To ensure that changes to the copied object do not affect the original, and vice versa.', 'What is the main goal when performing a deep copy regarding data independence?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '9a167ae3-3a6f-42e5-9f40-493df46ff3ca', '3f42f094-b2f1-4d96-93ba-d8ff989c4643', '```java
class Car {
    String make;
    int year;
}
```', 'Define a class (e.g., `Car`) with at least two instance variables (e.g., `make`, `year`).');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '9a167ae3-3a6f-42e5-9f40-493df46ff3ca', '67a4ed12-dfc5-4690-afc0-44f4b2a9e145', '```java
class Car {
    String make;
    int year;

    public Car() {
        this.make = "Unknown";
        this.year = 2023;
    }
}
```', 'Now, add a constructor to the `Car` class that sets initial default values for `make` (e.g., "Unknown") and `year` (e.g., 2023).');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '02588968-66cb-4567-b248-ee915fc77758', '3b807b9d-9d17-4c88-87a6-9ff91b2803e1', 'A class inheriting from a parent class.', 'What is the basic concept of inheritance in OOP?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '02588968-66cb-4567-b248-ee915fc77758', 'ebf7080e-31b0-479e-89d0-ca2e7f4a7081', 'One.', 'How many parents does a class typically inherit from in single inheritance?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '2ef714e8-f94a-4511-a648-9871b1642982', 'e957bc4c-ab3b-4422-b7ef-6f339b49cbdc', 'Code reuse or sharing of functionality.', 'What is a common positive aspect of any inheritance mechanism in OOP?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '2ef714e8-f94a-4511-a648-9871b1642982', '0b5299ff-9fe6-481c-9d7f-b227e08f7036', 'Increased complexity or design issues.', 'What is a known negative side effect of multiple inheritance mentioned in the context of design?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '4f0299ab-f1d6-4024-a818-6b0f07a1b57a', 'eda82e0a-3cca-46d3-a493-c9ec67ab65f6', 'Having multiple methods/constructors with the same name but different parameters.', 'What does ''overloading'' typically refer to in programming when applied to methods or constructors?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '4f0299ab-f1d6-4024-a818-6b0f07a1b57a', 'f7cd7bc5-5e43-432b-8c7a-33ae47c900fe', 'You could have two constructors: one with no parameters (default) and one with a parameter for the initial value.', 'If you have an object that can be created with or without an initial value for one of its properties, how might constructors help?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0b543673-4122-4f09-9489-4f598e1863ce', '2cb0a182-4838-46e2-8340-fa50176cd4e6', 'Their parameter lists (number, type, and order of parameters).', 'What distinguishes one overloaded method or constructor from another?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '0b543673-4122-4f09-9489-4f598e1863ce', 'cee63550-b967-4911-a318-249042497d4a', 'The constructor with no parameters.', 'If you call a constructor with no arguments, and there''s a constructor defined with no parameters, which one will the compiler choose?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '76c987e8-8ced-4eca-a880-d0c4c7c022bd', '626aead9-39f7-461c-b8c9-98e3b269190e', 'By their **parameter list** (the types and number of arguments they accept).', 'How are constructors with the same name differentiated by the compiler?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3b648229-1ae9-44b0-b110-795144560724', '72683d24-a265-4680-aaa8-2d5d521b6766', 'It means the object''s attributes are set to predefined, standard values if no specific initial data is given.', 'What does it mean for an object to be created with ''default'' values?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3b648229-1ae9-44b0-b110-795144560724', '2b70c892-f7c7-4506-8c2b-793be70d92da', 'With all data, you''d use a constructor that accepts all those parameters; with no data, you''d use a constructor that sets default values.', 'How would you create an object if you had all the data for its attributes right away, compared to if you had none?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '76c987e8-8ced-4eca-a880-d0c4c7c022bd', '4d205bfa-b7b8-442c-885f-025223573a78', 'The constructor with **no parameters**: `public Product()`.', 'If you call `new Product();`, which constructor would be invoked?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '72351141-4690-418a-ab49-5fc266bcde68', 'fd0a98df-67ca-4021-8df4-2400d94a5432', 'Abstract methods, which have no implementation.', 'What type of methods are typically declared in an interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'cba2963d-4aa1-4c97-9e43-f7122cff4c55', '6f53d7fe-8bf0-4492-a238-52381e3d617e', 'Interfaces typically contain abstract methods, which are method declarations without any implementation body.', 'What kind of methods do interfaces typically contain?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '72351141-4690-418a-ab49-5fc266bcde68', 'f0e69ec1-2b10-4ff2-afb1-ba8f7025794c', 'It means the class or method has a complete implementation and can be instantiated or directly executed.', 'What does ''concrete'' mean in the context of a class or method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'cba2963d-4aa1-4c97-9e43-f7122cff4c55', '36cc6614-6f22-491c-8bdb-6c2d899394af', 'It means the method has a body of code that defines its specific behaviour, rather than just a declaration.', 'What does ''concrete'' mean when referring to a method''s implementation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'de77a950-8e84-457d-b7b8-0443e6ebefe7', '5c63941e-089d-4235-bf59-aabfbfd22c74', 'A set of methods or behaviours that the implementing class promises to provide.', 'What does an interface define for a class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '9773f4f2-0c18-47d0-8c18-a566e51a2353', '589de452-fccd-4d63-907f-2da6eef45ca4', 'Use the `interface` keyword, followed by the interface name and then method signatures without bodies.', 'How do you define a basic interface in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'de77a950-8e84-457d-b7b8-0443e6ebefe7', 'a8a2de77-7450-407f-a5d2-6da53c507466', 'They all share a common set of behaviours defined by the interface, even if their internal implementations differ.', 'If multiple classes implement the same interface, what does that imply about their behaviour?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '9773f4f2-0c18-47d0-8c18-a566e51a2353', '2d60126d-e79a-4504-bca2-d9b810caf17a', 'The `implements` keyword is used, followed by the name of the interface.', 'What keyword is used by a class to declare that it will fulfill an interface''s contract?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'a92bd2e9-498b-4bcb-8c47-7a1acbe17a3c', '318eb1cd-0dc6-4207-aa4a-b4817d1ccace', 'An abstract class cannot be instantiated directly, while a concrete class can be.', 'What is the fundamental difference between an abstract class and a concrete class in terms of instantiation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'a92bd2e9-498b-4bcb-8c47-7a1acbe17a3c', '9ecd91a0-0784-47c7-b65e-756ec87eab90', 'The compiler checks and enforces that all abstract methods from an implemented interface have concrete implementations in the class.', 'What is the compiler''s role regarding interface contracts and method implementations?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '122ce3a7-5108-4093-a2ce-98b0d92a3064', '3c29aa38-8243-49d9-9a59-3067b05920d5', 'The loop''s code block', 'If an attribute is declared inside a `for` loop, what determines its accessibility?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '122ce3a7-5108-4093-a2ce-98b0d92a3064', '46f3a400-ba42-4f14-ac4c-8f1949d61c0b', 'They are deallocated from memory', 'When a method finishes executing, what happens to variables declared within it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'fa37af48-c661-4f27-a98b-2418bfe893b3', '9c391dec-6343-476d-b77b-d451136f4b6c', 'Yes', 'If a `Car` class has a `color` attribute, and you create `car1` and `car2`, can `car1` have a different colour than `car2`?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'fa37af48-c661-4f27-a98b-2418bfe893b3', 'd6dda02d-c526-40c8-a45e-92752e23c6bd', 'Instance variable', 'What is another common term for an object-scoped attribute?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c87a7c57-f62e-488a-89d0-3a2a066d9f4b', '5538e7ab-54aa-474c-8d44-144794cb09cf', '`static`', 'What keyword is used in Java to declare a class-scoped attribute?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c87a7c57-f62e-488a-89d0-3a2a066d9f4b', 'da647d51-43a1-4ee5-bda7-0c3fdcb65dde', 'The last value set by either object, as it is shared', 'If a class has a `static` `count` attribute, and two objects modify it, what is the final value?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '7c0e8f4c-e63b-43c5-ad93-357c4ab22a43', 'bda82ccf-643c-48fa-9823-857ea219cc8c', 'Within the method they are declared in', 'Where are method parameters considered to be ''scoped''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'dc44054b-3fe5-4c01-adc7-46b10405247d', '7cf8c1b0-2836-45c9-837e-03b20d3971bc', 'Any other object can directly modify it without control', 'If a sensitive attribute is `public`, what is a potential risk to data integrity?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '328b76e2-e5bf-40f2-b932-55035adbd3ed', '044283c6-56c1-45d1-bbc5-f009f1b0d8c6', 'Three (one for each object)', 'If you create three `Dog` objects, how many `name` attributes (object-scoped) are created?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'dc44054b-3fe5-4c01-adc7-46b10405247d', '7a30fa15-82d0-40da-8819-2b7b7473f435', 'They provide controlled access, allowing validation or other logic before modification', 'How do `private` attributes with accessor methods (getters/setters) improve data integrity?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b440b7de-c36f-46ce-ba9b-fc9e60558621', 'bfa0f978-c870-4ade-a18d-81b10dde6a9b', 'Polymorphism (specifically, operator overloading is a form of polymorphism)', 'What concept allows a single operator symbol to have different behaviours depending on the context (e.g., `+` for numbers versus strings)?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b440b7de-c36f-46ce-ba9b-fc9e60558621', 'af1aeb57-c3e0-4ab1-bfc3-e510cac5fac3', 'Define how the `+` operator should behave for that class.', 'When you use a mathematical operator like `+` with objects of a new class you''ve created, what might you need to do to make it work as expected?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0f7f5356-ab29-463a-ac1c-d557f77fd1ea', '98664df4-2252-4634-b973-70b85424d47e', 'Its name, what parameters it expects, and what type of value it returns.', 'If you are using a method written by someone else, what information do you absolutely need to know to use it correctly?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '0f7f5356-ab29-463a-ac1c-d557f77fd1ea', '39cfa2c5-dcf0-4b4d-b805-652963ee9363', 'No, the internal workings (method body) are usually hidden from the user.', 'Do you typically need to know the step-by-step internal workings of a method to simply call it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '6d635e86-f2fb-44a6-8e10-cbdd7ef21f5c', '4d569c31-a37c-4bf5-ab0c-56c559650ac0', 'Coupling.', 'What term describes the degree of direct knowledge one software component has of another?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '6d635e86-f2fb-44a6-8e10-cbdd7ef21f5c', '938971f5-e357-4da4-80ad-37fca3807c2a', 'It knows only the operations it can perform, not the specific type.', 'If a class uses an interface, does it know the specific type of object it is interacting with, or just the operations it can perform?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0d6e8529-998d-40dd-b048-fdb7c8685efa', '0eeb46df-59b1-4348-9ffe-cb4536b19328', 'Polymorphism', 'What concept allows objects of different classes to respond to the same method call in their own specific ways?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '0d6e8529-998d-40dd-b048-fdb7c8685efa', 'f96c8081-5140-42f8-b4c0-fc514f65835e', 'They define shared method signatures without providing implementation details.', 'How do interfaces help create a ''common type'' for unrelated classes?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '328b76e2-e5bf-40f2-b932-55035adbd3ed', '1788513c-4a34-4ca7-a2c3-df569b7d02fa', '`ClassName.companyName`', 'How would you access a `static` attribute called `companyName` from outside its class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '16d2527d-07b4-463d-9fc9-6065d521edab', '67d68092-e0a2-435f-8212-8d56a756611c', '`String part1 = "Hello";
String part2 = "World";`', 'Declare two `String` variables in Java, for example, `part1` and `part2`.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '16d2527d-07b4-463d-9fc9-6065d521edab', 'a79b1849-71a8-4820-a175-a4fc725ab313', '`String combined = part1 + part2;`', 'How would you combine `part1` and `part2` into a single `String` using the `+` operator, storing the result in a new variable?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '63165c20-1c2d-478d-83b6-225e7d4964a6', '85412197-da8b-4bdf-b8fb-5733003174ce', '`public`', 'What access modifier in Java typically indicates that a method is part of a class''s public contract?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '63165c20-1c2d-478d-83b6-225e7d4964a6', 'e8d761bb-918d-4d39-9b7a-58fdfa83ff72', 'Its implementation.', 'Is the internal logic of a method (its body) considered part of its interface or its implementation?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '9152f72e-7bb5-4ef0-93f1-dbdaca4e5f2e', '0f24cbc6-64b0-4650-bf18-7e40fd57be18', '`implements`', 'What keyword in Java indicates that a class will fulfil the contract of an interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '9152f72e-7bb5-4ef0-93f1-dbdaca4e5f2e', '2b13409f-a341-4451-8ae3-f27d1b5530c0', 'It allows the method to process any object that implements that interface.', 'If a method takes an interface as a parameter, what does that enable the method to do regarding different object types?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '868a1f17-d5d3-43fd-85cc-c3de38d12038', '804638ea-b07e-43b3-8f0b-8adaa686731f', 'An attribute', 'If a `Car` object, what might `color` be an example of?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '868a1f17-d5d3-43fd-85cc-c3de38d12038', 'cd2224cc-bdff-41ed-bf7a-712648636e89', 'A method', 'For a `Car` object, what might `startEngine()` be an example of?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '7c0e8f4c-e63b-43c5-ad93-357c4ab22a43', 'abbb03aa-f4e4-4887-9e52-b7926559ed5b', 'Class scope', 'If `totalTrips` were declared `static`, what would its scope be?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '69232c5a-00f6-4275-9798-19c5de2de367', 'd8494b36-5c7d-4b40-bf83-15d0b68e161f', 'It performs addition.', 'When the `+` operator is used with numeric values, what is its standard function?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '69232c5a-00f6-4275-9798-19c5de2de367', 'b330acac-4596-4a3b-af8c-6f953a2b06c8', 'The strings are joined together to form a new, single string (concatenation).', 'In Java, what happens when you use the `+` operator between two `String` objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'd054bcd5-05ee-421d-85e5-e73754034061', '19b4ede1-3833-48b1-8236-e158b5bfe51b', '`add(int a, int b)` along with its access modifier and return type.', 'Which part of the `add` method would another part of the program use to call it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'd054bcd5-05ee-421d-85e5-e73754034061', '0dc5e83b-5274-49d2-a0a3-904633991b6a', 'Inside the curly braces `{}` of the `add` method.', 'Where does the code that performs the addition calculation itself reside?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '4dcd8570-4b45-4806-93e6-5f5123c57455', '1b6b4942-d00b-4f70-92f6-3a433a66a102', 'The method''s name and the types/order of arguments you pass.', 'If you need to call a method, what specific details about it are necessary for the compiler to understand your call?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '4dcd8570-4b45-4806-93e6-5f5123c57455', 'ede5e762-38e6-4286-9748-28738321b729', 'No, that is the method''s body or implementation.', 'Is the code *inside* the curly braces `{}` of a method part of its signature?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '3384c462-7cdf-46b6-b83f-dc571709a61b', '5b7bfb51-a640-4df9-a640-2301acb6bed1', 'The `Moveable` interface.', 'If you have an `interface Moveable` with a `move()` method, and `Car` and `Bicycle` implement it, what is the ''common type''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '3384c462-7cdf-46b6-b83f-dc571709a61b', '8ebe1a6a-0af2-442b-bc28-5e67691d9099', 'Each concrete class (Car, Bicycle) provides its own specific implementation of `move()`.', 'How does `move()` behave differently for a `Car` versus a `Bicycle` when called through the `Moveable` interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'c529bc42-8bc1-462a-b08a-a9eb0d2fe311', '63cdb156-3721-4583-a50f-11985220f9ff', 'Restricting direct access to an object''s internal data', 'What is the main idea behind ''data hiding''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'c529bc42-8bc1-462a-b08a-a9eb0d2fe311', '7d3054f7-f675-498e-94b2-aa00ea6753b1', '`private`', 'Which access modifier is typically used to hide implementation details?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'afc2df53-9728-4108-a3b6-b164044ef33f', 'f49bf58a-63e6-4664-988d-37e005db1bf0', 'They must provide concrete implementations for all methods defined in the interface.', 'What must classes do if they declare that they ''implement'' an interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'afc2df53-9728-4108-a3b6-b164044ef33f', '47d6dd7b-ea0e-462e-9d4d-2cd9ab490e9e', 'Abstract methods.', 'What kind of methods are typically specified within an interface?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b4a79808-a9d4-46f5-9ba6-3481a5605a93', '6059c757-961b-4a54-b81d-5ce385681a46', 'It performs addition.', 'What is the common expectation of the `+` operator when used with numbers?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b4a79808-a9d4-46f5-9ba6-3481a5605a93', '1b132a39-b0d5-4201-a028-3c848dcf7faa', 'They would expect addition but get multiplication, leading to confusion, incorrect assumptions, and errors that are hard to trace.', 'If the `+` operator was overloaded to perform an unexpected operation, like multiplication, what issues might arise for someone reading the code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '504c44c2-7371-4b99-be54-a988c211ea39', '31344cb3-110e-4ccd-884c-f4784bd9d29f', 'How to call the method (its name, parameters, and return type).', 'What does the method signature primarily define for other parts of the code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '504c44c2-7371-4b99-be54-a988c211ea39', '2a901676-8b20-4d60-b97e-54af163d5878', 'No, because the external interaction point remains consistent.', 'If the ''how-to-call'' instructions don''t change, do you need to rewrite code that follows those instructions?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '0962e7e2-ca97-48ec-a9c0-8aa87f4cf573', '55f5c913-688a-49f8-af9d-96f1dad67745', 'The `IDataSource` interface (its methods and signatures).', 'What part of the `ReportGenerator`''s interaction remains constant regardless of the underlying data source?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '0962e7e2-ca97-48ec-a9c0-8aa87f4cf573', 'd62a3e1f-ae7e-4fb9-978d-352c2b4b3a00', 'It would likely require changes and recompilation.', 'In a tightly coupled system, what would likely happen to `ReportGenerator` if the data source changed?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'bef352b7-824a-45af-877e-74c4eb0e996d', 'ef3857ad-5dd5-4835-93ce-49b01f063dc3', 'It means the code can adapt easily to changes or new additions without needing significant modifications.', 'What does it mean for code to be ''flexible'' in an OOP context?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'bef352b7-824a-45af-877e-74c4eb0e996d', 'af2ddb2a-1157-4f4d-93e4-3e04888a5dbd', 'Write a method that takes `Shape` as a parameter and calls its `draw()` method.', 'If you have an `interface Shape` and `Circle` and `Square` implement it, how can you write generic code to draw any shape?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '265e1cb3-2a86-410b-bf9f-a8b7983311b2', '3b4f6ea5-5784-4441-9343-ad86d61745c1', 'Accessor methods (getters and setters)', 'What mechanism is typically used to safely read or change a `private` attribute?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '265e1cb3-2a86-410b-bf9f-a8b7983311b2', 'af6efab3-89bc-4b6a-b1de-bf58e1ddc18a', 'It can lead to unpredictable behavior, corrupted data, and makes debugging difficult.', 'Why is direct external modification of an object''s internal data generally discouraged?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'fe78ea63-8eb3-496b-9931-90430f1a864a', '420d949f-6372-479c-a223-f77efafb584d', '`interface`', 'What is the keyword that must be used to declare an interface in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'fe78ea63-8eb3-496b-9931-90430f1a864a', 'c1834f96-5e35-45f8-9485-c922210ca70e', 'No, they do not.', 'Do methods declared inside an interface typically have a method body with executable code?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '19c26b27-0805-4d79-8a3b-e4693d07f074', '7ab3a8d9-28b2-4f80-ae39-63abdabc64a7', 'The method''s name and its parameters.', 'What two primary components define a unique method call in Java?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '19c26b27-0805-4d79-8a3b-e4693d07f074', '460039a9-a884-4bcf-a24c-b58d573eb3c4', 'No, in languages like Java, the return type is not part of the method signature for overloading purposes, but it is part of the method''s declaration.', 'Does the return type of a method typically form part of its unique signature?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '5207e561-bc10-4a2f-af1f-07c0273ce717', '2109180f-17b2-49e8-9efc-58af74d145a3', 'To allow new functionality to be added without modifying existing, tested code.', 'What is the primary goal when designing for extensibility in a system like this?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '5207e561-bc10-4a2f-af1f-07c0273ce717', '422886e3-dfb8-441c-b10e-2a4eaf35ba49', 'It provides a standardised set of operations that any new implementation must adhere to, ensuring compatibility.', 'How does a ''contract'' (like an interface) help achieve this goal?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '520bbd96-53fc-4500-981d-651687e36258', 'ab6ef842-f8cd-4693-a47c-731aa98af5d9', 'Any object that implements the `Edible` interface.', 'If you have a method `processFood(Edible item)`, what kinds of objects can you pass to it?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '520bbd96-53fc-4500-981d-651687e36258', '012144e7-8268-443d-a8e1-e89d48c4a37b', 'It allows the code to work with a broader range of object types without needing to know their specific classes.', 'How does using an interface make your code more ''generic''?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '69f519f6-19ee-4c97-883a-f8416d75ad2c', '342d275b-49ea-47e5-897b-1dcd918bf32c', '`Data` or `Attributes`', 'What part of an object holds its data?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '69f519f6-19ee-4c97-883a-f8416d75ad2c', 'f01d88b4-5833-4db2-a06b-8bd1ea8889ab', 'The data or values an object holds at a specific time', 'What does ''state'' refer to in the context of an object?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'bfe72beb-d220-40a0-854a-d129979a2d89', 'f0b5599d-6268-481c-a816-8eb1e0468ffd', 'A method body or implementation.', 'What does an abstract method lack compared to a non-abstract method?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'bfe72beb-d220-40a0-854a-d129979a2d89', '286deeb1-198f-4ce0-a64d-ade5d6705ef5', 'In the implementing class itself.', 'If a class implements an interface, where does the actual code for the interface''s methods reside?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '711196d2-c155-40e7-84a9-eedee40b882a', '531ac883-0f3d-42d2-b4c8-fed83c3f6793', '```java
interface Animal {
    void makeSound();
}
```', 'First, define a Java `interface` named `Animal` with a single method `makeSound()`.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '711196d2-c155-40e7-84a9-eedee40b882a', '26c2e530-3679-4fd6-a3f4-d2e4acae49bb', '```java
class Dog implements Animal {
    public void makeSound() { System.out.println("Woof"); }
}
class Cat implements Animal {
    public void makeSound() { System.out.println("Meow"); }
}
public class SoundTest {
    public static void makeAnimalSound(Animal a) {
        a.makeSound();
    }
}
```', 'Next, create `Dog` and `Cat` classes that `implement Animal`, each with their own `makeSound()` output. Then, create a static method `makeAnimalSound(Animal a)` that calls `a.makeSound()`.');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, 'b02e77db-a2d3-441e-89ea-f993d82a0ba7', 'e036eae8-eebe-449d-b9bc-b50c6570db8b', 'In a single location shared by the class, not per object', 'Where in memory is a `static` attribute stored, relative to objects?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, 'b02e77db-a2d3-441e-89ea-f993d82a0ba7', '31c4cb01-fc97-4b73-b6d9-7a433a4e844e', '```static```', 'What keyword is used to declare a shared, class-level attribute?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (0, '46e76d0c-a956-47d0-aa16-08b2e36ea235', '4cf468c6-c456-4bf5-b2c5-5038f4f2018a', 'Polymorphism (or abstraction).', 'What concept allows you to interact with an object based on its type (the interface) rather than its specific class?');
INSERT INTO public.scaffolds (order_index, question_id, scaffold_id, scaffold_correct_answer, scaffold_text) VALUES (1, '46e76d0c-a956-47d0-aa16-08b2e36ea235', 'df47a877-9aac-4b4f-b864-620427f3a636', 'They both guarantee to provide the methods defined in that interface.', 'If two unrelated classes both implement the same interface, what common aspect do they share?');


--
-- Data for Name: strategy_interaction_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('f4f36107-3f2b-4195-8f36-c598c165ac6a', 'QUESTION_ATTEMPTED', 1, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('f145f688-5563-4cc1-94d9-23df87624fa0', 'QUESTION_ATTEMPTED', 1, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('f67211d0-d3d4-496f-9764-29a130b6c6f7', 'QUESTION_ATTEMPTED', 1, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('f67211d0-d3d4-496f-9764-29a130b6c6f7', 'SCAFFOLD_ATTEMPTED', 0.3, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('b0b8f0ae-94e1-43a9-8b9c-97b966e1d5f0', 'QUESTION_ATTEMPTED', 1, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('b0b8f0ae-94e1-43a9-8b9c-97b966e1d5f0', 'SCAFFOLD_ATTEMPTED', 0.3, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('b0b8f0ae-94e1-43a9-8b9c-97b966e1d5f0', 'HINT_REQUESTED', 0.2, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');
INSERT INTO public.strategy_interaction_rules (strategy_id, interaction_type, mastery_update_weight, is_required, created_at, updated_at) VALUES ('f145f688-5563-4cc1-94d9-23df87624fa0', 'HINT_REQUESTED', 0.2, true, '2025-08-24 08:08:29.414775', '2025-08-24 08:08:29.414775');


--
-- Data for Name: written_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('44504bb0-41e4-4434-a968-5714eb084a44', 'This demonstrates code reuse: `Car` and `Bike` inherit `start()` and `stop()` from `Vehicle` rather than duplicating code.', 'By defining a general `Vehicle` class with shared methods like `start()` and `stop()`, subclasses such as `Car` and `Bike` can reuse these methods without rewriting code:

```java
class Vehicle {
  void start() { System.out.println("Vehicle started"); }
  void stop() { System.out.println("Vehicle stopped"); }
}
class Car extends Vehicle {}
class Bike extends Vehicle {}
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('a5ac4e35-eac4-4e71-bee8-4eddd314b4ce', 'The answer shows that a subclass inherits behavior from the superclass (`start()` method) and adds new functionality (`openTrunk()`).', 'A **superclass** (or parent class) defines general properties and methods. A **subclass** (or child class) inherits these properties/methods and can extend or override them. Example:

```java
class Vehicle {
  void start() { System.out.println("Vehicle started"); }
}
class Car extends Vehicle {
  void openTrunk() { System.out.println("Trunk opened"); }
}
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8d256539-243c-47a4-a5cf-eed9f5eacfd3', 'The answer provides clear definitions of abstract classes and methods, explaining their purpose in defining contracts and hiding implementation details for extensibility and polymorphism. The Java code snippets demonstrate how to declare an abstract class and method, and how a concrete subclass provides the implementation.', 'An **abstract class** is a class that cannot be instantiated on its own [128, user query]. It is designed to be a blueprint for other classes, providing a common structure and potentially some shared, concrete implementations. An **abstract method** is a method declared within an abstract class that has no implementation (no method body). Subclasses that extend the abstract class are *required* to provide their own concrete implementation for all inherited abstract methods [user query, 128, 130].

They are used to:
*   **Define a common interface/contract**: Abstract methods create a ''contract'' that forces all concrete subclasses to implement specific behaviours, ensuring consistency across a hierarchy (e.g., all `Shape` subclasses must define how they calculate their area).
*   **Promote extensibility and polymorphism**: You can program to the abstract `Shape` type, and the correct `calculateArea()` method for a `Circle` or `Rectangle` will be called at runtime, without needing to know the specific type beforehand. This allows new concrete subclasses to be added easily without altering existing code.
*   **Hide complex details**: The abstract class focuses on *what* an object does (its essential features) rather than *how* it does it (its implementation details), which is left to its concrete subclasses [user query, 102, 107].

```java
public abstract class Shape {
    // Abstract method: declares a method that subclasses must implement
    public abstract double calculateArea();

    // An abstract class can also have concrete methods with implementations
    public void displayType() {
        System.out.println("This is a general shape.");
    }
}

public class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public double calculateArea() {
        return Math.PI * radius * radius;
    }
}
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c7a789dd-c64a-4153-901f-bc24d9762b23', 'This explains the minimal public interface principle, linking it to the reduction of dependencies and how this reduction directly leads to more adaptable and flexible interfaces by containing the impact of changes.', 'The **''minimal public interface''** principle advocates exposing only the **absolutely essential functionalities** that users (other objects or developers) need to interact with a class, hiding all unnecessary internal details. This approach makes interfaces adaptable because it **reduces external dependencies** on the class''s internal structure and logic. When only essential behaviours are exposed, changes to the class''s private implementation or internal workings are less likely to ''break'' external code, thus promoting flexibility and ease of maintenance.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('154bbdc2-abff-4c83-bd3c-4cdc1ec7e1ca', 'This explanation defines abstraction in UI design, clarifies its role in flexibility, and uses the provided example of a data entry field to show how the user interface remains stable despite varied implementations.', '**Abstraction** in user interface design focuses on **essential features and common functionalities**, rather than specific implementation details. This approach allows the underlying system''s implementation to change or evolve without requiring alterations to how the user interacts with the interface. For example, a ''data entry field'' is an abstract concept; it can be flexibly implemented as a text box, a dropdown menu, or a slider, depending on the context, without changing the user''s fundamental understanding of ''entering data''.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('3ade7bbc-8cbc-4e63-8938-1f3ceb75f941', 'The provided code correctly extends the abstract `Vehicle` class and implements its abstract `start()` method. The explanation clearly links the code to the concept of abstraction, detailing how the common interface is defined at the abstract level and how complex implementation details are hidden within the concrete subclass.', '```java
public abstract class Vehicle {
    public abstract void start(); // Abstract method - no implementation

    public void stop() { // Concrete method - implementation provided
        System.out.println("Vehicle stopped.");
    }
}

public class Car extends Vehicle {
    @Override
    public void start() { // Concrete implementation of the abstract method
        System.out.println("Car engine starts with an ignition key turn.");
    }

    // Car can also have its own specific methods
    public void honk() {
        System.out.println("Honk honk!");
    }
}
```

This demonstrates **abstraction** because:
1.  The `Vehicle` class defines a common **interface** (`start()`) that all vehicles *must* support [user query, 128]. It establishes a general concept without specifying the details.
2.  The `Car` subclass provides the **specific implementation** of `start()` that is relevant to a car (`"Car engine starts with an ignition key turn."`) [user query, 130].
3.  When interacting with a `Car` object as a `Vehicle` type (e.g., `Vehicle myVehicle = new Car(); myVehicle.start();`), the user or other parts of the system only need to know that a `Vehicle` can `start()`. They don''t need to know the complex internal mechanisms (e.g., fuel injection, spark plugs, battery) involved in a car''s starting process [user query, 102]. The `Car` hides these implementation details behind the simple `start()` interface, showcasing abstraction.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('f7fd4704-fd08-412d-b755-f9462210bfac', 'The example shows Dog inheriting from Mammal, demonstrating that a subclass can use methods of its superclass.', '```java
class Mammal {
    void breathe() {
        System.out.println("Mammal is breathing.");
    }
}

class Dog extends Mammal {
    void bark() {
        System.out.println("Dog is barking.");
    }
}

public class TestRelationship {
    public static void main(String[] args) {
        Dog fido = new Dog();
        fido.breathe(); // Dog ''is-a'' Mammal
        fido.bark();
    }
}
```

The `Dog` class extends `Mammal`, so a `Dog` **is a** `Mammal` and can use its methods, demonstrating the ''is-a'' relationship.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('7f9befc5-45dc-4f2b-9a6b-9de14edae151', 'This explanation shows that ''is-a'' defines a subclass as a type of its superclass, allowing it to inherit behavior while adding unique features.', 'The **''is-a'' relationship** signifies that a subclass is a **type of** its superclass. For example, a `Car` is a `Vehicle`, or a `Dog` is a `Mammal`. This relationship is fundamental because it allows the subclass to inherit attributes and methods from the superclass while adding its own, promoting code reuse and clear class organization.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('ea50d206-0377-4a0d-9874-64993cc01d6f', 'This shows that ''is-a'' allows subclasses to reuse code from a superclass, reducing duplication and making maintenance easier.', 'The main advantage of ''is-a'' relationships is **code reusability**. Subclasses inherit attributes and methods from the superclass, so common behavior only needs to be written once and can be reused across multiple subclasses, reducing duplication and simplifying maintenance.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c1504e54-0457-462b-97ca-5d6f3a42f676', 'This explanation clearly defines abstract methods as declarations without implementation and explains how they create a binding contract for subclasses, crucial for consistent behaviour across a hierarchy.', 'The purpose of an **abstract method** in an abstract class is to **declare a required behaviour without providing its implementation**. It serves as a blueprint or promise that any concrete subclass must fulfill. This establishes a ''contract'' because it forces concrete subclasses to provide their own specific implementation for that method, ensuring that all subclasses adhere to a common interface while allowing for diverse underlying functionalities (polymorphism).');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('9f0cdb7c-0837-479d-949e-3e68500974b1', 'The example effectively showcases an abstract method in a superclass and its concrete implementation in a subclass, illustrating the fulfilment of an abstract contract through code and explaining the key elements.', '```java
public abstract class Animal {
    public abstract void makeSound();
}

public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof!");
    }
}

public class TestAnimal {
    public static void main(String[] args) {
        Dog myDog = new Dog();
        myDog.makeSound(); // Dog implements the contract
    }
}
```
This example demonstrates ''implementing abstract contracts'' as the `Animal` abstract class declares the **`makeSound()`** abstract method, setting a contract that any concrete subclass must fulfill. The **`Dog`** class `extends Animal` and provides the **concrete implementation** for `makeSound()`, thereby fulfilling this contract. If `Dog` did not implement `makeSound()`, it would have to be declared `abstract` itself.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c94e5bb0-f813-4bfb-8bda-6fcadb1e1f0f', 'This explanation correctly identifies that the subclass becomes abstract and cannot be instantiated, linking this back to the purpose of abstract methods in enforcing a contract for concrete implementations.', 'If a concrete class inherits from an abstract class but fails to provide a concrete implementation for all of its abstract methods, that **subclass itself becomes abstract**. This means that the subclass **cannot be directly instantiated** into an object, as abstract classes cannot be directly instantiated. The compiler will enforce this rule, preventing the code from compiling unless the subclass is explicitly declared `abstract`. This ensures that any object created from a class in that hierarchy will always have a concrete implementation for all the methods declared in its abstract contract.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('4f0cbbc6-c474-4e0c-9320-b296775bc1b2', 'This explanation defines abstraction in UI design, clarifies its role in flexibility, and uses the provided example of a data entry field to show how the user interface remains stable despite varied implementations.', '**Abstraction** in user interface design focuses on **essential features and common functionalities**, rather than specific implementation details. This approach allows the underlying system''s implementation to change or evolve without requiring alterations to how the user interacts with the interface. For example, a ''data entry field'' is an abstract concept; it can be flexibly implemented as a text box, a dropdown menu, or a slider, depending on the context, without changing the user''s fundamental understanding of ''entering data''.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('a34bbf1b-b3df-4738-a4e4-6f29b0caf125', 'This explanation distinguishes between the visible contract of a method (interface) and its hidden internal workings (implementation), providing a clear Java signature example.', 'The **interface** of a method defines its public signature, including its **name, parameters, and return type**, indicating **what** the method does and **how to call it**. The **implementation** is the actual **code inside the method** that dictates **how** the operation is performed, which is typically hidden from external users. For example, the interface for a method could be `public String getName()`, communicating that it returns a `String` representing a name, but not revealing the internal logic used to retrieve that name.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('1d14c4fb-d009-4c10-9d82-36d79e9d7642', 'This explanation distinguishes between the visible contract of a method (interface) and its hidden internal workings (implementation), providing a clear Java signature example.', 'The **interface** of a method defines its public signature, including its **name, parameters, and return type**, indicating **what** the method does and **how to call it**. The **implementation** is the actual **code inside the method** that dictates **how** the operation is performed, which is typically hidden from external users. For example, the interface for a method could be `public String getName()`, communicating that it returns a `String` representing a name, but not revealing the internal logic used to retrieve that name.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('efe8be5f-f686-4710-aac0-666b9ef5b86e', 'This explains the minimal public interface principle, linking it to the reduction of dependencies and how this reduction directly leads to more adaptable and flexible interfaces by containing the impact of changes.', 'The **''minimal public interface''** principle advocates exposing only the **absolutely essential functionalities** that users (other objects or developers) need to interact with a class, hiding all unnecessary internal details. This approach makes interfaces adaptable because it **reduces external dependencies** on the class''s internal structure and logic. When only essential behaviours are exposed, changes to the class''s private implementation or internal workings are less likely to ''break'' external code, thus promoting flexibility and ease of maintenance.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('a58e3c86-b89e-4c45-b5d1-ffd972671849', 'This explanation defines abstraction in UI design, clarifies its role in flexibility, and uses the provided example of a data entry field to show how the user interface remains stable despite varied implementations.', '**Abstraction** in user interface design focuses on **essential features and common functionalities**, rather than specific implementation details. This approach allows the underlying system''s implementation to change or evolve without requiring alterations to how the user interacts with the interface. For example, a ''data entry field'' is an abstract concept; it can be flexibly implemented as a text box, a dropdown menu, or a slider, depending on the context, without changing the user''s fundamental understanding of ''entering data''.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('985cc2aa-9595-4ba0-a70a-2451b5ddc8a6', 'This explanation distinguishes between the visible contract of a method (interface) and its hidden internal workings (implementation), providing a clear Java signature example.', 'The **interface** of a method defines its public signature, including its **name, parameters, and return type**, indicating **what** the method does and **how to call it**. The **implementation** is the actual **code inside the method** that dictates **how** the operation is performed, which is typically hidden from external users. For example, the interface for a method could be `public String getName()`, communicating that it returns a `String` representing a name, but not revealing the internal logic used to retrieve that name.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('feb4a19d-55b1-4e3d-8614-17cc940d2f67', 'This explains the minimal public interface principle, linking it to the reduction of dependencies and how this reduction directly leads to more adaptable and flexible interfaces by containing the impact of changes.', 'The **''minimal public interface''** principle advocates exposing only the **absolutely essential functionalities** that users (other objects or developers) need to interact with a class, hiding all unnecessary internal details. This approach makes interfaces adaptable because it **reduces external dependencies** on the class''s internal structure and logic. When only essential behaviours are exposed, changes to the class''s private implementation or internal workings are less likely to ''break'' external code, thus promoting flexibility and ease of maintenance.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('e5c0f586-2eff-4f41-abdc-09c9b61e689e', 'This explanation clarifies that abstract interfaces define broad goals, allowing for varied implementations and consistent interaction, which directly fosters reusability by decoupling components and promoting interchangeability.', 'Designing abstract interfaces promotes higher reusability by defining **general user goals** rather than specific implementation steps. This allows diverse classes to implement the same interface in their own unique ways, depending on their context. The interface remains consistent, enabling other parts of the system to interact with any implementing class without needing to know its internal details, thereby facilitating interchangeability and reducing code dependencies.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('2705f7df-f1f1-4c99-89a9-b97639d0cc30', 'The example demonstrates an abstract interface (`Drivable`) implemented by concrete classes (`Car`, `Airplane`), each with its unique method. The `TravelAgent` then uses the common interface, showcasing how the ''what'' (going to a destination) remains consistent while the ''how'' (driving, flying) can vary, promoting reusability.', '```java
// Abstract Interface defining a general user goal
interface Drivable {
    void goToDestination(String destination);
}

// Specific implementation 1
class Car implements Drivable {
    @Override
    public void goToDestination(String destination) {
        System.out.println("Driving to " + destination + " using roads.");
    }
}

// Specific implementation 2
class Airplane implements Drivable {
    @Override
    public void goToDestination(String destination) {
        System.out.println("Flying to " + destination + " through the air.");
    }
}

// Reusable code interacting with the abstract interface
public class TravelAgent {
    public static void arrangeTravel(Drivable vehicle, String destination) {
        vehicle.goToDestination(destination);
    }

    public static void main(String[] args) {
        Car myCar = new Car();
        Airplane myAirplane = new Airplane();

        arrangeTravel(myCar, "City Center");
        arrangeTravel(myAirplane, "New York");
    }
}
```

The `Drivable` interface defines a general goal (`goToDestination`) without specifying the travel method. `Car` and `Airplane` provide diverse, specific implementations. The `TravelAgent` class uses the abstract `Drivable` interface, allowing it to work with any vehicle implementing `Drivable` consistently, regardless of how they achieve the destination.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c2204b5d-e5dd-4d7c-9751-6f2a071f8200', 'Abstract interfaces create a clear boundary between a class''s public contract and its private internal workings. This separation means that modifications to the hidden implementation do not necessitate changes to external code, provided the interface itself remains stable.', 'An abstract interface acts as a contract, defining only the public methods that other parts of the system can interact with. By separating the interface from the internal implementation, changes to the class''s private methods or logic will **not affect external users**, as long as the public interface remains unchanged. This protection ensures that dependent code does not break, enhancing stability and reducing maintenance effort.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('fb960709-a4bd-41c0-8910-608b719b65af', 'Focusing on general user goals in interface design ensures that the interface remains broad and adaptable, supporting a greater variety of specific implementations. This flexibility is essential for achieving high reusability, as the interface can consistently serve different scenarios.', 'Identifying general user goals is crucial because it leads to the creation of interfaces that define **broad capabilities** rather than narrow operations. This allows the interface to be relevant and applicable across a wide array of **diverse, specific contexts** and implementations. If an interface is tied to highly specific details, it becomes less flexible and harder to reuse, as it might not fit slightly different contexts without modification.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('0d5f0624-1d15-4004-87e9-3d7743f90e8c', 'Object behaviors are derived from user needs. Identifying user actions like making calls or sending messages directly informs the design of corresponding methods for the object.', 'To determine necessary behaviors for a `Smartphone` object from a typical user''s perspective, designers identify actions the user would perform. These user actions are then translated into the object''s methods. For example, a user would want to **`makeCall()`** or **`sendTextMessage()`**. Other behaviors could include `takePhoto()` or `browseInternet()`.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('973ab281-fd9b-4760-a64c-f49a9b59b314', 'User needs dictate `turnOn()`/`turnOff()` behaviors. Power instability, an environmental constraint, leads to design features like `restoreLastState()` to manage unexpected power loss.', 'A core behavior for a `SmartLight` from a user''s perspective is **`turnOn()` / `turnOff()`**. This directly translates user control into a method. A potential environmental constraint is **power supply stability**. If power fluctuates, the `SmartLight` might be designed with a `restoreLastState()` method or a default "off" state upon power return, to handle the limitation imposed by an unstable power source.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('515d04cd-f8ec-4910-ac7f-721d95562b65', 'Environmental constraints dictate functional limitations. If an internet connection is constrained, the thermostat''s design must account for basic operation, ensuring resilience despite external limitations.', 'An environmental constraint can directly limit a `SmartThermostat`''s functionality. For example, if the internet connection is an **environmental constraint**, the thermostat might be designed to have **limited functionality or fall back to basic operation** (e.g., only local temperature adjustment) when offline, rather than relying on cloud-based scheduling or remote control.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('35334e96-d0bb-4935-8f22-e968575056b4', 'Identifying users (human, object, system) ensures the interface supports all required interactions like turning on/off, adjusting brightness, or reporting energy usage from all relevant perspectives, leading to a complete and usable design.', 'For a `SmartLight` class, users could include an **end-customer** (e.g., using a mobile app to turn it on), a **voice assistant object** (e.g., `Alexa` sending a message to `turnOn()`), or an **energy management system** (another interacting object requesting `currentPowerConsumption()`). Identifying these is crucial to ensure the interface supports diverse commands, data requests, and integrates seamlessly into various environments, fulfilling all necessary requirements.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('65c484a7-d54d-4cf1-9d19-9a63290029ea', 'Methods encapsulate the functionality, enabling objects to exhibit specific behaviors and respond to messages from other objects.', 'Methods define the **behaviors** or **actions** an object can perform. They allow objects to interact, manipulate their own data, and provide services, such as a `Car`''s `startEngine()` method.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('be8aa773-2d03-42a5-8ad3-ec04bf5f022c', 'A `Printer` class serves human users, other objects (like a `Document` sending print data), and internal systems (like a `PrintQueue` managing jobs), each requiring specific interface methods to fulfill their roles.', 'Besides a human user, a `Printer` class could have a **`Document` object** (another interacting object requesting `print()` services) and a **`PrintQueue` system** (an internal role or system managing print jobs). The `Document` object would expect an interface to send document data for printing, while the `PrintQueue` would need interfaces to check printer status, manage job order (`addToQueue()`, `getNextJob()`), and receive completion notifications.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('619f0ba2-97b9-413d-9e97-d1f2c3d273ca', 'Attributes encapsulate an object''s internal data, distinguishing one instance from another and allowing it to hold unique information.', 'Attributes define the **data** or **properties** of a class, representing an object''s state. For instance, `eyeColor` for a `Dog` object stores its specific state.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('57b54c7a-c7ef-47c2-8bf2-aa351abbf02c', 'Conflicting requirements from different user types are managed by designing an interface that provides tailored access or views of the class''s functionality, ensuring all needs are met without compromising overall usability.', 'A `NavigationSystem` might face conflicts: the **driver** (end-customer) prioritises simple, clear directions and minimal distractions (e.g., concise `nextTurn()`), while the **mapping service** (interacting object) requires detailed, complex data for route calculation and traffic updates (e.g., extensive `getRoadData()`). Understanding both user types allows designers to create an interface that offers a simplified, high-level `driverView()` for the human while exposing a rich, detailed `dataFeed()` interface for the automated service, ensuring a realistic and usable system through a balanced design.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('ad35ba58-7918-4923-a4cf-9b7e963d1961', 'This explanation clearly defines both terms and links their separation directly to improved modularity by promoting independent component design.', 'Separating interface from implementation means defining **what** a class does (its public interface) independently of **how** it achieves it (its internal implementation). This is crucial for **modularity** because it allows different parts of a system to interact without needing to know each other''s complex internal details, making components independent and interchangeable.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('98d159c6-bbca-4f86-ad25-74d43e7deb31', 'This structure clearly separates the class''s identity, its data, and its operations as per UML conventions, ensuring a well-defined class blueprint.', 'For the `Book` class in a UML Class Diagram:
1.  **Class Name:** `Book` (top section)
2.  **Attributes:**
    *   `-title: String`
    *   `-numberOfPages: int`
3.  **Methods:**
    *   `+openBook(): void`

Private attributes use `-` and public methods use `+`.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8aa229f7-ddbd-48c5-98df-b71a16f1790d', 'Methods are the active components of an object, defining its capabilities. They encapsulate the object''s logic, supporting the principle of data hiding by controlling how internal data is accessed and modified.', 'A method signifies a **behavior** or **action** that an object can perform. It defines **what the object can do**. Methods contribute to an object''s functionality by encapsulating specific operations. By combining data (attributes) and methods within the same entity, methods also support **encapsulation**, allowing controlled access to an object''s internal state and hiding implementation details.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('f7c8818a-70da-461a-8cd6-7bcd9ec592f2', 'Comments provide essential context and explanations for code, detailing its function and logic. This clarity is paramount for team collaboration, debugging, and efficient maintenance over the software''s lifecycle.', 'Comments are crucial because they clarify the **purpose and behavior** of classes and their internal components. They help document the **function of a class** and its **internal logic**, making the code more understandable for other developers (or the original developer in the future). This increased clarity directly **facilitates maintenance**, as it''s easier to debug, extend, or modify code whose intent is clearly documented.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('bfc5d85e-b231-4037-a1f6-9142e7fb50bd', 'The example demonstrates private attribute declaration and access through public methods, supporting data hiding for control and integrity.', '```java
public class Thermostat {
    private double currentTemperature; // Private attribute

    public void setTargetTemperature(double temp) { // Public method (interface)
        if (temp >= 15.0 && temp <= 30.0) { // Example validation
            this.currentTemperature = temp;
        }
    }

    public double getCurrentTemperature() { // Public method (interface)
        return this.currentTemperature;
    }
}
```
Attributes are kept `private` as part of the implementation to **control access** and ensure **data integrity**. Other objects interact with them only through public methods (like `setTargetTemperature()` or `getCurrentTemperature()` in the example), which can validate input or perform necessary operations before changing the internal state.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('d068acdf-93d0-4b60-aa34-acad18893d24', 'Single-line comments are for brevity on one line using `//`, while multi-line comments (`/* */`) are for longer explanations over several lines. Forgetting the `*/` in a multi-line comment can cause the compiler to treat executable code as comments, leading to errors.', '**Single-line comments** begin with `//` and comment out everything from that point until the end of the line. They are typically used for brief notes or commenting out a single line of code. **Multi-line comments** begin with `/*` and end with `*/`, allowing text to span across multiple lines, usually for larger explanations or block-commenting code. A common issue if a multi-line comment is not properly terminated with `*/` is that the **compiler will ignore all subsequent code** until it finds a `*/` or the end of the file, leading to compilation errors or unexpected program behavior.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('eacbbb4f-993c-4307-8144-552cfdfaeff9', 'This explanation clearly connects the separation to maintainability and illustrates it with a practical scenario, highlighting that external code remains unaffected by internal logic changes.', 'When the logic of a method changes, separating interface from implementation ensures that **only the internal implementation needs modification**, while the public interface remains stable. For instance, consider a `PaymentProcessor` class with a public `processPayment(double amount)` method. If the internal algorithm for verifying the payment (e.g., changing from one fraud detection service to another) needs to be updated, only the code within the `processPayment` method''s implementation needs changing. Any external system calling `paymentProcessor.processPayment(amount)` will continue to work without modification or recompilation, greatly simplifying maintenance and reducing the risk of errors.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('f50a4a8f-aa6a-41ec-b276-db271e9fa419', 'This code demonstrates declaring a `public` method named `bark()` within the `Dog` class. The method encapsulates the action of printing ''Woof!'', defining a distinct behavior for a `Dog` object.', '```java
public class Dog {
    public void bark() {
        System.out.println("Woof!");
    }
}
```
The `bark()` method defines a specific **action or behavior** that any `Dog` object can perform. When this method is called, it executes the enclosed logic, making the `Dog` object exhibit the behavior of barking.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('967d8f4c-60e0-40ef-9795-217aee6dbc6a', 'This snippet correctly uses `//` for a concise, single-line explanation of an attribute and `/* */` for a multi-line description of a method''s behavior. Both demonstrate proper comment syntax and usage.', '```java
public class Car {
    private String model; // Represents the car''s model name

    /*
     * This method defines the action of starting the car''s engine.
     * It simulates the car''s readiness for operation.
     */
    public void startEngine() {
        System.out.println("Car engine started.");
    }
}
```

The single-line comment `// Represents the car''s model name` clarifies the `model` attribute''s purpose concisely. The multi-line comment, enclosed by `/*` and `*/`, provides a more detailed explanation for the `startEngine()` method, outlining its functionality and intent over several lines.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('382dbf51-54df-428c-a443-dc3f00368652', 'Designing minimal and hidden interfaces ensures that the class''s external API is clean and stable. This reduces complexity for users and allows the class''s internal implementation to be modified without forcing changes in dependent external code, improving maintainability and reducing the risk of bugs.', 'Public interfaces should be **minimal** to provide users with only the essential functionality they need, ensuring conciseness and ease of use. Keeping **internal workings hidden** prevents external code from becoming dependent on implementation details, which facilitates proper design and simplifies future maintenance and changes without affecting external code.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c2d99813-7881-4e6d-98c1-ed22d048f251', 'Exposing internal details creates strong dependencies, or ''coupling'', between a class and its users. This means that any internal refactoring or bug fixes can unexpectedly break external code, resulting in increased development costs and reduced system stability over time.', 'If public interface methods are not minimal and expose internal details, external code might become **directly coupled** to the class''s internal implementation. This leads to **fragile code**, where changes to the class''s internal structure or logic will necessitate modifications and recompilations in all external code that relies on those exposed details, making the system difficult to maintain and more prone to errors.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('e84854d9-db4b-40ef-ba4b-478218616486', 'Instantiation is the essential step that brings a class, which is a conceptual blueprint, into existence as a usable object in memory. This allows a programmer to work with the class''s defined services and data in a practical context.', 'Understanding instantiation is crucial because it is the process of creating a concrete object from a class''s abstract blueprint in memory. Without instantiation, the class remains just a definition, and its functionalities (methods) and data storage (attributes) cannot be utilised or interacted with as a live entity.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('2bfc0ea9-d292-4009-87af-67661206e9f5', 'This line of code uses the `new` keyword to create a new instance of the `Book` class, assigning it to the `myBook` variable. This process is known as instantiation.', '```java
Book myBook = new Book();
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('eca7d620-d9fe-4e39-b83b-4e2f86a9126a', 'The sender is the active entity sending a request, and the message content defines the precise action and data involved in that request for the receiving object to understand and execute.', 'The **sender object** is the object that initiates the communication by invoking a method on another object. The **message content** refers to the specific method call, including its name and any arguments passed, which tells the receiver what operation to perform.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('9593327a-46a8-4b5c-8f3f-c74f415152c9', 'The `LightSwitch` object acts as the sender by invoking the `turnOn()` method on the `connectedLight` object. The `connectedLight` object is the receiver, and `turnOn()` is the specific message (method call) that instructs the light to change its state.', '```java
class Light {
    void turnOn() {
        System.out.println("Light is ON.");
    }
}

class LightSwitch {
    Light connectedLight;

    LightSwitch(Light aLight) {
        this.connectedLight = aLight;
    }

    void press() {
        connectedLight.turnOn(); // This is the message sending action
    }
}
```

In the `connectedLight.turnOn();` line:
*   **Sender object**: The `LightSwitch` object (specifically, the `this` implicit reference within its `press()` method).
*   **Receiver object**: The `connectedLight` object (an instance of the `Light` class).
*   **Message content**: The `turnOn()` method call.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('58e808a3-5068-4574-8363-08b530c39c85', 'This explanation shows that ''private'' variables and ''public'' accessor methods form a controlled interface, central to encapsulation. This design protects the object''s internal state and allows for the enforcement of business rules, leading to benefits like enhanced data integrity.', 'Encapsulation involves packaging an object''s data (attributes) and behavior (methods) into a single unit, while hiding internal details. By declaring instance variables as **private**, their direct access from outside the class is restricted. **Public getter and setter methods** then provide a controlled interface for other objects to interact with these private variables. This approach ensures that the object''s internal state can only be manipulated or viewed through defined channels. A specific benefit of this is **data integrity**, as setter methods can include validation logic to prevent invalid data from corrupting the object''s state before it is assigned.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('20fa95aa-aa2a-4af1-b70c-3edb8c95c546', 'Providing only a getter for `productID` effectively makes the attribute read-only. This is crucial for identifiers that, by design, should not be modifiable after creation, as it prevents unintended changes and reinforces the object''s immutability, thereby improving data integrity and consistency.', 'The `productID` might have a getter but no setter because a product''s ID is typically a unique identifier assigned once (e.g., during object creation) and should remain **immutable** throughout its lifecycle. This prevents external code from accidentally or intentionally altering a critical identifier, ensuring consistency and uniqueness. This design choice directly supports the principle of **read-only access** to the `productID`, which enhances data integrity and system reliability.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('b05e73a0-963f-49ea-9a47-caa551dfc530', 'This explanation highlights how controlled access enhances robustness and how localized changes due to separation improve testability, using a concrete example to illustrate the concept.', 'Separating a class''s interface from its implementation contributes to a more **robust** system by allowing the class to **control access** to its internal data and logic, preventing unintended external manipulation. This control ensures data integrity and helps the object maintain a stable state. It improves **testability** because internal changes or bug fixes can be made without requiring widespread retesting of dependent components, as long as the public interface remains consistent. For example, if a `Square` class has a `getArea()` public interface and its internal `calculateSquare()` implementation method is changed to improve efficiency, other parts of the system using `getArea()` do not need modification or extensive retesting because the external contract has not changed.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('1aaabfab-be55-4b3d-b54e-0aff1e187e69', 'The code showcases how `private` fields coupled with `public` accessor methods enable controlled interaction. The conditional logic within the setter specifically enforces data validation, ensuring that the `grade` attribute adheres to defined business rules (0-100), which is a core benefit for data integrity.', '```java
class Student {
    private int grade; // Private instance variable

    // Setter with validation for grade (0-100)
    public void setGrade(int newGrade) {
        if (newGrade >= 0 && newGrade <= 100) {
            this.grade = newGrade; // Assign only if valid
        } else {
            System.out.println("Invalid grade: " + newGrade + ". Grade must be between 0 and 100.");
        }
    }

    // Getter for grade
    public int getGrade() {
        return this.grade;
    }
}
```
This example demonstrates **controlled access** because the `grade` variable is declared as `private`, preventing direct modification from outside the `Student` class. Any external code must use the `setGrade` method. It demonstrates **data validation** because the `setGrade` method contains an `if` statement that checks if `newGrade` is within the acceptable range (0 to 100). If the value is outside this range, the assignment is rejected, ensuring the `grade` always holds a valid value.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('665f4941-f8bc-4a30-9e12-a10bfbf95f71', '`private` enforces internal data hiding, while `public` provides controlled external access, together supporting encapsulation.', 'The fundamental difference lies in their **visibility and accessibility**. `private` members (attributes or methods) can **only be accessed from within the class** in which they are declared. In contrast, `public` members can be **accessed from any other class or object** in the program, serving as the class''s exposed interface for interaction.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('be10e514-f9ec-46bc-b4ef-18fad43eea8e', 'The example demonstrates how `private` attributes combined with `public` accessor methods centralise control over data, which is the essence of encapsulation.', '```java
class Person {
    private String name; // Private attribute

    public String getName() { // Public method (getter)
        return name;
    }

    public void setName(String newName) { // Public method (setter)
        this.name = newName;
    }
}
```
This setup enforces encapsulation because the `name` attribute is declared `private`, which means it cannot be directly accessed or modified from outside the `Person` class. Instead, external interactions are forced through the `public` methods, `getName()` and `setName()`, allowing the class to control and potentially validate the data.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('61de4ab3-c8bf-4c2e-a44f-5aaf389c9dcb', '`private` attributes allow the class to impose rules on how its data is accessed and changed, which is crucial for preventing invalid states and maintaining data accuracy.', 'Declaring attributes as `private` ensures data integrity by preventing their direct modification by external code. This forces other objects to interact with the data solely through the class''s `public` methods. The class can then implement validation logic or business rules within these methods, ensuring that the internal state remains valid and consistent, thus protecting against unintended corruption.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('fa909bd7-503d-4a32-80a3-0dfabb66e28c', 'Descriptive class names are essential because they directly convey the class''s function, aiding in understanding and maintaining the codebase.', 'Class names should be **descriptive** to clearly communicate the class''s purpose and functionality. This helps developers, including yourself in the future, quickly understand what the class represents and how it should be used, improving code readability and making maintenance easier. For example, `AccountManager` is more descriptive than `AM` for a class managing user accounts.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('869c489f-10db-42ae-9162-e3f850680d42', 'Adhering to naming standards promotes uniformity, which simplifies code comprehension and enhances maintainability, especially in collaborative environments.', 'Following **established coding standards** for class naming is important because it ensures **consistency** and **predictability** across an entire project or development team. This reduces ambiguity and makes the codebase easier to read, navigate, and maintain for all developers, leading to fewer errors and more efficient collaboration. It also ensures adherence to widely accepted best practices.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('b20e6ce6-92d9-48be-aa48-f3b39ffa0705', 'A minimal interface reduces the complexity for users, strengthens data protection by restricting access, and reduces interdependencies between classes, leading to more robust systems.', 'Designing a class with an absolute minimal user interface **simplifies class usage** for external users by reducing complexity. It also **enhances security** by controlling access to sensitive data, and **prevents unnecessary coupling** between classes.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('67f2465f-458e-448b-8de8-a90c8c09884b', 'User feedback helps identify genuine needs for additional public methods, guiding the iterative refinement of a class''s interface to remain minimal yet functional and user-centric.', '**User feedback** is crucial for **iteratively adding** public methods to a class. After the initial design with minimal public methods, more are added only when explicitly required or **identified through user feedback**. This ensures the interface truly meets user needs without exposing unnecessary functionality.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8738dab3-6b5a-436a-ab21-c01ff9d152a4', 'Hiding private methods ensures that external users only interact with the intended public functionalities, which reduces complexity and protects the class''s internal state from unintended manipulation. This adheres to the principle of providing a minimal public interface.', 'Private methods are hidden from the public interface because they are strictly part of the **class''s internal implementation** and are **not intended for direct access by other classes**. One benefit is **simplifying class usage** for external users, as they only interact with what they absolutely need. Another benefit is **enhancing security** by controlling access to sensitive data and preventing unnecessary coupling.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('4a7a5ce9-66ed-46c0-a816-e8ae9a6ea7ea', 'This example illustrates how public methods act as the gateway for external interaction, delegating internal, specific tasks to private helper methods. This maintains a clean public interface and encapsulates complex implementation details.', 'A public method like `giveDestination(String destination)` in a `Cabbie` class could internally call private methods such as `turnRight()`, `turnLeft()`, or `accelerate()`. For example, a user invokes `cabbie.giveDestination("Airport")`. The `giveDestination()` method then orchestrates the internal navigation by calling `turnRight()` and `turnLeft()` as needed. This design ensures that the user only interacts with the public `giveDestination()` interface, while the specific, encapsulated steering and movement tasks remain hidden.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('98243b86-e221-473a-98c5-c00ae328fe1b', 'This explanation identifies direct attribute manipulation as the bad practice, links it to violations of data hiding and tight coupling, and details the negative consequences for control, validation, maintenance, and bug risk.', 'The bad practice in `TransactionProcessor` is the **direct manipulation of `account.balance`**. Even if `balance` were made public, allowing `TransactionProcessor` to directly change `account.balance` violates **data hiding** and leads to **tightly coupled code**. This is problematic because the `Account` class loses control over its own state; `TransactionProcessor` bypasses the `withdraw` method which contains important logic (like checking for sufficient funds). If the internal representation or validation logic of `Account` changes (e.g., adding transaction logging or new validation rules), `TransactionProcessor` would also need modification, increasing maintenance effort and the risk of bugs.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('6819a748-cf5b-43b3-826a-97d50a102445', 'This example provides Java code showing a superclass method overridden in a subclass, and then demonstrates polymorphic behaviour by calling the overridden method through a superclass reference, explaining the runtime dispatch of method calls.', '```java
class Animal {
    public void makeSound() {
        System.out.println("Generic animal sound");
    }
}

class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof! Woof!");
    }
}

public class PolymorphismDemo {
    public static void main(String[] args) {
        Animal myAnimal = new Animal();
        Animal myDogAsAnimal = new Dog(); // Polymorphic reference
        Dog myDog = new Dog();

        System.out.print("My generic animal: ");
        myAnimal.makeSound();

        System.out.print("My dog (as animal type): ");
        myDogAsAnimal.makeSound(); // Calls Dog''s overridden method

        System.out.print("My dog (as dog type): ");
        myDog.makeSound();
    }
}
```

This code demonstrates polymorphism via method overriding. The `Animal` class has a generic `makeSound()` method. The `Dog` subclass **overrides** this method to provide a specific ''Woof! Woof!'' sound. When `myDogAsAnimal` (declared as `Animal` but instantiated as `Dog`) calls `makeSound()`, the Java Virtual Machine (JVM) calls the `Dog`''s specific `makeSound()` method at runtime, showing **polymorphism** (many forms of the same method call).');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8c98acc5-84cc-49d8-912d-ff555fe516ca', 'Getters uphold encapsulation by hiding internal representation. They provide a controlled interface for retrieving data, enabling validation, logging, or complex computations without exposing the raw attribute.', 'Using accessor methods (getters) is preferred because it enforces **encapsulation** and **data hiding**. Getters provide **controlled access** to an object''s attributes, allowing the class to validate or process data before it''s retrieved, and to change internal implementation without affecting external code. This improves data integrity, security, and maintainability.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('251883e1-d851-447c-b986-be4dcab5dcc5', 'A ''has-a'' relationship defines a whole-part dependency where a class possesses or is built from instances of other classes, which is the core principle of object composition. This allows for building complex objects from simpler, reusable components.', 'The **''has-a'' relationship** describes when one class contains or is composed of an instance of another class. It implies that an object is a part of another object or that one object uses another as a component. It is implemented using **object composition** by declaring an instance of one class as a member variable (attribute) within another class. For example, a `Library` class ''has a'' `Book` object. The `Library` is composed of many `Book` objects, but each `Book` can exist independently of a specific `Library`.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8e02cc12-78ee-4cea-ac09-849fecd1bb0d', 'The **superclass** defines general characteristics, while the **subclass** inherits and specialises these, forming an ''is-a'' relationship through inheritance.', 'A **superclass** (or parent class) is a class that provides common attributes and behaviours to be inherited by other classes. A **subclass** (or child class) is a class that inherits these attributes and methods from a superclass, extending or specialising its functionality. This relationship is established through **inheritance**, representing an ''is-a'' relationship. For example, if a `Car` class inherits from a `Vehicle` class, `Vehicle` is the superclass, and `Car` is the subclass. This means a `Car` ''is a'' `Vehicle`, inheriting common vehicle properties like `speed` and `colour`, and adding specific car properties like `numberOfDoors`.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('730403b9-5558-4ed7-9d18-5d9a4cabc6b6', 'The function name `calculateSum` identifies the operation. `num1` and `num2` are the input parameters, both of integer type. The `int` before `calculateSum` specifies that the function will return an integer value.', '**Function Name:** `calculateSum`
**Parameters:** `num1` (of type `int`), `num2` (of type `int`)
**Return Type:** `int`');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c8bee84d-ebc6-4abb-8b4f-f38a2d2eb398', 'When `mainVar` (a primitive type) is passed to `modifyValue`, a **new local variable** `inputVar` is created within the `modifyValue` function, which receives a copy of `mainVar`''s value. Modifications to `inputVar` are confined to `modifyValue`''s scope and do not alter `mainVar`.', 'The console will print "Value in main: 10". This is because `inputVar` in `modifyValue` is a **local copy** of `mainVar`. Changes to `inputVar` within the `modifyValue` function do not affect the original `mainVar` in the `main` method.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('e99fa713-6d2d-49b8-b4d3-f2cd7b4ab625', 'This explanation defines method overriding and polymorphism, then illustrates how a `Dog`''s specific `makeSound()` behaviour demonstrates these concepts when treated as a generic `Animal`.', 'Polymorphism through method overriding means that a **subclass provides a specific implementation of a method already defined in its superclass**, allowing objects of different classes to be treated as objects of a common type. For example, an `Animal` superclass might have a generic `makeSound()` method. A `Dog` subclass can **override** this method to `bark()`, so when `makeSound()` is called on a `Dog` object (treated as an `Animal`), it barks instead of making a generic sound. This enhances flexibility by allowing common interactions with diverse objects.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8e07dd6d-3caa-451d-ba20-63ce996bdeea', 'This explanation clarifies how method overriding supports extensibility by enabling the addition of new, specific object types and behaviours without altering previously implemented code designed for generic superclass types.', 'Polymorphism through method overriding greatly enhances extensibility by allowing new subclasses to be introduced with their own specific implementations of superclass methods, **without requiring modification to existing code that interacts with the superclass type**. For instance, if an `Animal` class has a `makeSound()` method, adding a new `Cat` subclass that overrides `makeSound()` means any part of the system designed to work with generic `Animal` objects can automatically handle `Cat` objects and invoke their specific sound, making the system easy to expand with new types and behaviours.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8b0ed57a-7211-4c31-b3ec-d5e15c44f356', 'This code illustrates direct access to a public attribute (`color`) of the `myCar` object using dot notation (`myCar.color`). While possible for public attributes, direct access is generally discouraged for data integrity.', '```java
class Car {
    public String color = "Red";
}

public class TestCar {
    public static void main(String[] args) {
        Car myCar = new Car();
        System.out.println("The car''s color is: " + myCar.color);
    }
}
```
This example defines a `Car` class with a `public` `color` attribute. The line `myCar.color` directly accesses the `color` attribute of the `myCar` object to retrieve its value and display it.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('788b54c3-e1cf-4883-b691-3783e5aafc47', 'Association indicates a general connection between objects. Aggregation specifies a "whole-part" relationship where parts can exist independently, distinct from composition which implies dependent parts.', '**Association** is a general relationship indicating that one class uses or is connected to another. It''s represented by a **simple solid line** between classes. An example is a `Student` attending a `Course`. The `Course` can exist without the `Student`, and vice versa.

**Aggregation** is a specific type of association that represents a "whole-part" relationship where the parts can exist independently of the whole. It''s represented by a **hollow diamond** at the ''whole'' end of the line. An example is a `Department` having `Professors`. A `Professor` can exist independently of the `Department` and can be assigned to another department.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('ce667025-d1fe-4ad1-bc40-1171d0560aa8', 'The diagram illustrates inheritance (is-a) with a solid line and hollow arrowhead, aggregation (part-whole with independent parts) with a hollow diamond, and association (general connection) with a simple line, each depicted with distinct UML symbols signifying varying levels of dependency and structural roles.', '1.  **`Dog` to `Mammal` (Solid line, hollow arrowhead):** This represents **Inheritance**. It means that a `Dog` **is-a** `Mammal`, inheriting its attributes and behaviours.
2.  **`Dog` to `Head` (Solid line, hollow diamond on `Dog` end):** This represents **Aggregation**. It means a `Dog` **has-a** `Head`, but the `Head` can exist independently of that specific `Dog` (e.g., a head could be detached and still be a head, conceptually, or be part of a generic `BodyPart` pool).
3.  **`Dog` to `Owner` (Simple solid line):** This represents **Association**. It means there is a general connection or relationship between `Dog` and `Owner`. An `Owner` can exist without owning a `Dog`, and a `Dog` can exist without an `Owner`. They interact but are independent.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('edd8fd58-924f-4435-8f3b-d17bfe66ef90', '`Instrument` is the **superclass** as it is extended, and `Guitar` is the **subclass** because it uses the `extends` keyword to inherit from `Instrument`.', '```java
class Instrument {
    void play() {
        // common play logic
    }
}

class Guitar extends Instrument {
    void strum() {
        // guitar specific logic
    }
}
```
In this code snippet, `Instrument` is the **superclass**, and `Guitar` is the **subclass**. The keyword `extends` in `class Guitar extends Instrument` signifies that `Guitar` inherits from `Instrument`. This means `Guitar` gains all the attributes and methods of `Instrument` and can also define its own.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('309ea252-d17c-403f-92d2-c2463b94ef45', 'The `getAbsoluteValue` function is defined to take an integer `number` and return its positive equivalent. The `main` method then calls this function with `-7` and prints the returned absolute value.', '```java
public class MathOperations {

    public static int getAbsoluteValue(int number) {
        if (number < 0) {
            return -number;
        } else {
            return number;
        }
    }

    public static void main(String[] args) {
        int originalNumber = -7;
        int absoluteResult = getAbsoluteValue(originalNumber);
        System.out.println("The absolute value of " + originalNumber + " is: " + absoluteResult);
    }
}
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('231e02a7-1000-4323-a5c7-67cd2575e870', 'Object composition offers greater flexibility and reduces coupling compared to inheritance for ''has-a'' relationships. This allows components to be reused and maintained independently, simplifying system changes and promoting modular design.', 'Two advantages of using **object composition** for a ''has-a'' relationship compared to inheritance are:
1.  **Promotes code reuse and flexibility:** Composition allows components to be developed and reused independently across different ''whole'' objects without being tied to a rigid inheritance hierarchy. For example, a `Wheel` class can be reused in a `Car`, a `Bicycle`, or a `Cart` without requiring these to be part of a single ''wheeled'' hierarchy.
2.  **Reduces coupling and simplifies maintenance:** Composition generally leads to loosely coupled systems. Changes to a component class only affect the class that directly contains it, rather than potentially impacting an entire inheritance tree. This makes systems easier to modify and maintain over time.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c6da3044-b2e9-4480-87f5-c150f9545467', 'Parameter passing offers explicit and controlled data exchange, enhancing modularity. Global variables provide direct access but sacrifice control and predictability, increasing debugging difficulty and side effects.', '- **Parameter Passing**: Data is explicitly passed into or out of functions via arguments.
    - **Advantage**: Provides **controlled data flow**, making functions more modular, predictable, and easier to test and reuse, as their inputs and outputs are clear.
    - **Disadvantage**: Can become cumbersome if a function requires many parameters, making function signatures long and complex.
- **Global Variables**: Data is declared outside of any function and can be accessed and modified directly by any part of the program.
    - **Advantage**: Easy and quick to access data from any part of the program without explicit passing.
    - **Disadvantage**: Leads to **uncontrolled and unpredictable data access**, making debugging difficult and increasing the risk of unintended side effects and reduced code maintainability.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('fcd44ed1-4891-4261-a81b-2b15e73b9cd1', 'This explanation identifies the problem with global data in procedural programming and contrasts it with the solution of encapsulation in OOP for better data control.', 'A major drawback of using global data in procedural programming is that it often leads to **uncontrolled and unpredictable access**, as multiple functions can directly modify the same global data. This makes testing and debugging significantly more difficult. Object-oriented programming addresses this by `encapsulating` data (attributes) and operations (methods) within a single object, allowing `controlled access` to data only through defined methods, thus improving data integrity.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c854590d-1141-42be-90b8-47a91d59afe5', 'When global data is widely accessible, it can be **modified by any part of the program**, making it hard to predict its state and debug issues, as access is ''uncontrolled and unpredictable''. This increases the likelihood of unintended side effects.', 'A significant disadvantage of extensive global variable use is that it makes data access **uncontrolled and unpredictable**. Multiple functions can access and modify a global variable, making it difficult to track where and when a variable''s value changes, leading to challenging debugging and potential unintended side effects.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('0b3be419-77cf-4989-af13-efa2987a79f9', 'This explanation defines the separation and highlights the issue of global data leading to uncontrolled access and complexities in development.', 'In procedural programming, data (attributes) is typically **separated from the functions or procedures** (operations) that manipulate it. A significant implication of this is that data is often `global`, allowing multiple, logically unconnected functions to `directly modify` the same data. This can lead to uncontrolled and unpredictable data access, making testing and debugging more difficult.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('d727fb5a-5aa3-447a-a256-45f62f356f59', 'This response highlights that procedural global data can be accessed unpredictably. Encapsulation resolves this by restricting data access to an object''s own methods, thereby improving data integrity.', 'In procedural programming, data is often global and separate from procedures, leading to uncontrolled and unpredictable access where multiple functions can modify it. **Data encapsulation** in OOP addresses this by combining attributes (data) and methods (behaviors) within a single object. This design allows access to the object''s data to be controlled solely through its methods, preventing external functions from directly manipulating internal data and thus ensuring data integrity and making debugging easier.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('29ffb430-c86d-4925-9382-1f7cc5f5663d', 'This explanation outlines how OOP''s encapsulation and modularity help overcome the challenges of uncontrolled data and rigid code in large procedural systems, enabling better organization and maintainability.', 'OOP emerged because procedural programming often leads to global data and separated logic, which becomes difficult to manage, test, and debug in complex systems. OOP addresses this by encapsulating data and behavior within objects, promoting modularity and controlled interactions. This approach allows complex systems to be broken down into smaller, manageable, and reusable components, making them more robust and easier to maintain and extend, especially for network-based applications.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('5312c739-2cae-4c6a-978f-3634c3105920', 'This explanation illustrates that procedural programming separates data from logic, while OOP encapsulates them within objects. This difference affects how systems are designed and how data is accessed and manipulated.', 'In **procedural programming**, employee data (like hours worked, hourly rate) would likely be stored in separate data structures (e.g., arrays or records), and the payroll calculation logic would be in a standalone function or procedure, taking employee data as input. In **object-oriented programming**, an `Employee` object would encapsulate both the employee''s data (attributes like `hoursWorked`, `hourlyRate`) and the `calculatePay()` method (behavior) that operates on that data. The payroll system would then interact with `Employee` objects by sending messages (calling methods) to compute pay for each.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('3b35054e-7697-46f7-9301-ac5691b66c3a', 'A class defines the structure and behavior for objects. It acts as a blueprint, allowing multiple distinct objects to be created based on a single, shared definition.', 'A **class** serves as a **blueprint** by defining the common attributes (data) and methods (behaviors) that all objects created from it will possess. It''s a template, not an actual instance. Just as an architect''s blueprint specifies the design for multiple buildings, a class specifies the design for multiple **objects**. 

For example:
```java
class Dog {
    String name;
    int age;

    void bark() {
        System.out.println("Woof!");
    }
}

// Creating objects (instances) from the Dog blueprint
Dog myDog = new Dog();
Dog yourDog = new Dog();
```
In this example, `Dog` is the class (blueprint) defining `name`, `age`, and `bark()`. `myDog` and `yourDog` are distinct objects (instances) created from this blueprint, each having their own `name` and `age` but sharing the `bark()` behavior defined in the class.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('123297ed-89d4-43dd-affc-3abecee73495', 'Defining a class centralises the definition of data and behavior for an entity. This enables developers to create reusable, modular objects, reducing code duplication and simplifying future modifications and maintenance.', 'The **fundamental purpose of defining a class structure** in OOP is to **organise code** into logical, self-contained units. Each class encapsulates related data (attributes) and behavior (methods) for a specific entity.

This structure promotes **code reusability** because the class acts as a template. Once defined, a class can be used repeatedly to create many **modular components** (objects), each with its own state but sharing the common functionality defined in the class. This avoids duplicating code and simplifies maintenance.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('5988473a-c9b8-4bcc-bd43-e63330582112', 'Attributes define the data that each object of a class will possess. They store the unique characteristics or state of individual objects, differentiating them even when they share the same class blueprint. This allows for distinct instances of the same class.', 'An **attribute** within a class definition represents a data field that holds information or a characteristic specific to each **object instance** of that class. It defines the state of an individual object. Each object created from the same class will have its own copy of these attributes, allowing them to store different values and thus have unique states.

For example:
```python
class Robot:
    def __init__(self, name, model):
        self.name = name  # Instance attribute
        self.model = model # Instance attribute

# Creating two distinct robot objects
robot1 = Robot("Unit-01", "R2D2")
robot2 = Robot("Sparky", "C3PO")

# Each robot object has its own unique ''name'' and ''model'' attributes
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('07966f05-f013-4dbd-9fe8-b41160502f18', 'Attributes are essential because they capture the dynamic and unique data that defines an object''s specific condition or status at any given time. This ''state'' allows objects to behave distinctly and represent different real-world entities, making them more useful and versatile in a program.', 'Defining attributes is fundamental for storing an object''s **state** because attributes are the data fields that hold the unique characteristics and values for each specific object instance. Without attributes, all objects of a class would effectively be identical, lacking any distinct data to differentiate them. They allow an object to ''remember'' its current condition, such as a `Car` object having a `current_speed` or `fuel_level` attribute. This state can change over time through interactions and operations, but it is always stored in its attributes.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('68b87841-9f59-414c-942c-446ff38b225b', 'The explanation details the roles of `try` and `catch` blocks in handling a specific type of runtime error, ensuring program stability.', 'A `try` block encloses code that might cause an `ArithmeticException`, such as division by zero. If this exception occurs, control is transferred to a corresponding `catch` block, which contains code to handle the exception gracefully, preventing a program crash.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('4a5fa5c3-abf0-4c04-817f-232c1d3783c0', 'A **class** is a conceptual definition, a design pattern for objects, detailing what attributes and methods they will have. An **object** is a tangible entity created from that class, holding unique data for its attributes and capable of performing the methods defined by its class. The class describes the ''type'', while the object is a ''specific instance'' of that type.', 'A **class** is a blueprint or template that defines the structure (attributes) and behavior (methods) common to a specific type of entity. It is a logical construct that does not occupy memory for specific data itself. An **object**, on the other hand, is a concrete instance created from that class. Each object has its own unique set of data values for the attributes defined by its class, and it occupies memory. An object is a ''real-world'' entity within the program.

For example:
```java
class Pen { // This is the Class (the blueprint)
    String color; // An attribute defined by the class
    int inkLevel; // Another attribute

    void write() { // A method defined by the class
        // code for writing
    }
}

// In a main method or other part of the program:
Pen myBluePen = new Pen(); // ''myBluePen'' is an Object (an instance) of the Pen class
myBluePen.color = "blue"; // This object has its own unique color
myBluePen.inkLevel = 100; // This object has its own unique ink level

Pen myRedPen = new Pen(); // ''myRedPen'' is another Object of the Pen class
myRedPen.color = "red"; // It has its own distinct color
myRedPen.inkLevel = 75; // And its own ink level
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('f7459686-8887-423d-ae3d-a62fda75aed3', 'Invoking `homeAlarm.activateSensor("FrontDoor");` directs the `homeAlarm` object to execute its `activateSensor` logic with the provided sensor name. This demonstrates triggering a defined behavior on a specific object instance with necessary input.', '```java
homeAlarm.activateSensor("FrontDoor");
```
Executing this line of code **signifies that the specific `homeAlarm` object is being instructed to perform its `activateSensor` behavior**. It passes the `String` value "FrontDoor" as an argument to the method, indicating which sensor should be activated by this particular alarm instance.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8be897a9-f1af-4b6a-a2d5-a89d3600fa12', 'The `grade` attribute is declared `private` to restrict direct access, while the `setGrade` method is `public`, providing controlled modification. The validation logic within `setGrade` ensures that the `grade` remains within acceptable bounds, upholding data integrity. The `getGrade` method provides controlled read access.', '```java
public class Student {
    private int grade;

    public void setGrade(int newGrade) {
        if (newGrade >= 0 && newGrade <= 100) {
            this.grade = newGrade;
        } else {
            System.out.println("Invalid grade. Grade must be between 0 and 100.");
        }
    }

    public int getGrade() {
        return grade;
    }
}
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('57707cb3-aee9-40a9-92f7-da8262a2b142', 'This example clearly shows a private attribute with public getter/setter methods, illustrating how encapsulation hides internal data and provides controlled access, aligning with data protection principles.', '```java
public class BankAccount {
    private double balance; // Internal detail, hidden

    public BankAccount(double initialBalance) {
        if (initialBalance >= 0) {
            this.balance = initialBalance;
        } else {
            this.balance = 0;
        }
    }

    // Public interface to get balance (controlled access)
    public double getBalance() {
        return this.balance;
    }

    // Public interface to modify balance (controlled modification)
    public void deposit(double amount) {
        if (amount > 0) {
            this.balance += amount;
        }
    }
}
```
This example shows encapsulation because the `balance` attribute is **`private`**, meaning it cannot be directly accessed or modified from outside the `BankAccount` class. Instead, external code must use the **`public` methods `getBalance()` and `deposit()`** to interact with the balance, demonstrating controlled access and data hiding.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('7b6d54b5-fa55-4382-be72-f747bad7417e', 'The example effectively uses a `Door` object as an attribute within `House` to show composition. The explanation highlights modularity and flexibility, key benefits of composition.', '```java
class Door {
    String material;
    public Door(String material) {
        this.material = material;
    }
    public void open() {
        System.out.println("Opening a " + material + " door.");
    }
}

class House {
    private Door frontDoor;
    public House() {
        this.frontDoor = new Door("wood"); // House has a Door
    }
    public void enter() {
        frontDoor.open();
        System.out.println("Entering the house.");
    }
}
```

This example shows a `House` class containing an instance of a `Door` class as a private attribute (`frontDoor`), illustrating that a `House` ''has a'' `Door`. An advantage of this is **modularity and flexibility**: the `Door` can be reused in other `House` objects or even other structures, and the `Door`''s implementation can change independently of the `House`''s, as long as its interface remains consistent.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('62e80cc5-e273-4dc2-8003-48cd4998e516', 'The response highlights improved stability and user experience as key benefits of graceful exception handling.', 'The primary benefit of handling exceptions is to allow programs to detect and respond to unexpected events gracefully, preventing abrupt crashes. This improves software by enhancing its stability and reliability, leading to a better user experience as the program can recover or exit safely.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('bfd15738-1c67-4904-af32-5847677740ee', 'The distinction is vital because a class provides the reusable template for creating objects, promoting design consistency and code efficiency. Objects, as individual instantiations, enable the system to manage multiple unique entities that share common characteristics but have their own distinct data, which is fundamental for building complex, real-world models in software.', 'Differentiating between a **class** and an **object** is crucial because it allows developers to separate the definition of a type from its concrete manifestations. A **class** provides a single, reusable blueprint for structuring data and behavior, which promotes code reuse and consistency across a system. **Objects**, as instances of classes, allow for multiple distinct entities to exist based on that single blueprint, each with its own unique state and independent operation. This separation enables modular design, making systems easier to understand, extend, and maintain, as changes to the blueprint (class) can propagate to all instances (objects) in a controlled manner, and individual object states are managed distinctly.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('0f221384-6792-4873-a41e-bcbfcbcc3bab', 'Invoking a method on an object causes that specific object to execute the code defined within that method, triggering its unique behavior. It is the way to interact with an object and make it perform an action.', 'Invoking a method on an object is like pressing a button on a remote control for a specific device. The remote (your code) sends a signal (invokes a method) to the device (the object), telling it to perform a predefined action, like turning on or changing the channel.

For example, if you have a `Car` object named `myCar` and you want it to start, you would invoke its `startEngine` method:
```java
class Car {
    void startEngine() {
        System.out.println("Engine started.");
    }
}

public class Main {
    public static void main(String[] args) {
        Car myCar = new Car(); // Object instantiated
        myCar.startEngine(); // Method invoked
    }
}
```
This code tells the specific `myCar` object to execute its `startEngine` behavior.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('8fd4e29c-a7ab-49a4-a824-73388a5437e1', 'Encapsulation centralizes control over data, preventing external code from directly manipulating it. This leads to more reliable data and easier updates to internal logic without breaking dependent code.', 'Encapsulation ensures that an object''s internal data can only be accessed or modified through its public methods (like getters and setters). This **controlled access** protects data from invalid or unintended changes, thereby enhancing **data integrity**. For **maintainability**, if the internal representation or logic of the data changes, only the methods within that encapsulated class need to be updated, without affecting external code that uses the public interface.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('b4483529-0e67-44cb-aaf4-6188838ffc87', 'Direct public access to an attribute bypasses any control or validation logic, leading to the potential for corrupted or invalid data (loss of data integrity). It also complicates debugging because there is no single point of control for modifications, making it difficult to trace where an incorrect value originated.', 'If a `Product` class has a `public price` attribute instead of a `private` one with a setter, any part of the program could directly modify the `price` without validation. A significant negative consequence is **loss of data integrity**. For example, `myProduct.price = -50;` would allow a negative price, which is invalid in most business contexts. This also severely impacts **maintainability** and **debugging**, as tracking down where an incorrect `price` value originated becomes very difficult since any part of the system could have modified it.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('35a0b16b-7fad-4c90-ba92-8bf155a529fc', 'Polymorphism, meaning ''many shapes'', is achieved when different objects respond to the same message in unique ways. Interfaces and abstract classes establish the common ''message'' (method signature) while deferring the ''response'' (implementation) to specific classes.', 'Both interfaces and abstract classes define a contract for methods that must be implemented by concrete subclasses or implementing classes. This allows objects of different classes, which share a common interface or abstract base, to be treated as objects of the common type and respond uniquely to the same method call, demonstrating polymorphism.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('833a3045-a4d6-4c02-8f2e-0f6c26dae31a', 'This distinction highlights how abstract classes provide a shared foundation for related types, while interfaces enable diverse types to adhere to a common behavioural contract.', 'An **abstract class** is suitable when you have a hierarchy of related classes sharing common core characteristics and some default behaviours, but requiring specific implementations for others. For example, a `Vehicle` abstract class could define `startEngine()` (concrete) and `drive()` (abstract), with `Car` and `Motorcycle` extending it.

An **interface** is ideal when defining a contract of capabilities that various, potentially unrelated, classes can fulfil. For example, a `Flyable` interface with a `fly()` method could be implemented by a `Bird` class and a `Plane` class, despite their different types.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('c15717c4-7451-4bca-84e4-254ecf57f785', 'Interfaces, by their nature of being purely abstract, prevent implementers from depending on any specific code. This contrasts with abstract classes, whose shared implementation can create hidden dependencies and propagate changes across child classes.', 'Interfaces exclusively define a contract of methods without any implementation, ensuring that classes implementing them are only coupled to the method signatures, not to any underlying code. Abstract classes, conversely, can include concrete methods, which means changes to that shared implementation can ripple through subclasses, creating tighter coupling within the hierarchy. This makes interfaces more flexible for varying implementations.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('01f03e7f-da6e-4fa9-8159-a1fea5aaedf7', 'This explanation focuses on how encapsulation restricts direct data access and uses controlled methods (getters/setters) to maintain data integrity and prevent external code from causing unintended issues.', 'Encapsulation protects data by **hiding an object''s internal attributes** from direct external access. Instead, data is accessed and modified only through **public methods** (getters and setters). This control prevents other parts of the system from inadvertently corrupting or misusing the data, thus preventing unintended side effects and ensuring data integrity.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('744685e6-7137-4b21-863d-11ae6a0a0c9b', 'This explanation highlights how encapsulation creates independent modules by hiding implementation details, which in turn reduces the impact of changes and localises errors, simplifying maintenance and debugging.', 'Encapsulation enhances modularity by making objects **self-contained units** with clearly defined public interfaces and hidden internal implementations. This isolation means changes to an object''s internal workings do not affect external code, making individual modules easier to develop and test. For maintenance and debugging, issues can be **isolated within a single class**, reducing the scope of potential problems and making them quicker to identify and fix.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('85659db5-9f04-4f40-abfb-88d79ee46520', 'This explanation clearly defines ''is-a'' as inheritance (subtype relationship) and ''has-a'' as composition (part-whole relationship), with relevant examples distinguishing between them.', 'An **''is-a'' relationship** signifies inheritance, where a subclass is a specialised version of its superclass. For example, a `Dog` *is an* `Animal`. A **''has-a'' relationship** signifies composition, where one class contains another class as a component or attribute. For example, a `Car` *has an* `Engine`.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('3ce63e14-c932-4217-8575-a147a6586eeb', 'The code provides a clear example of handling `ArithmeticException` with `try` and `catch`, and the explanation describes how it illustrates the concept.', '```java
public class ExceptionExample {
    public static void main(String[] args) {
        try {
            int numerator = 10;
            int denominator = 0;
            int result = numerator / denominator; // This will throw ArithmeticException
            System.out.println("Result: " + result);
        } catch (ArithmeticException e) {
            System.out.println("Error: Division by zero is not allowed.");
        }
    }
}
```
This example demonstrates how the `try` block encloses the division operation, and the `catch` block handles the `ArithmeticException` when division by zero occurs.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('747b45af-0497-4668-95ac-9c135897bc3f', 'This highlights that shared references in a shallow copy mean modifications to nested objects are reflected in both the original and copied objects, compromising data independence.', 'When a shallow copy is made, only the references to nested objects are duplicated, not the nested objects themselves. This means both the original and the copied object will point to the same nested objects. Consequently, a change to a nested object through one reference (either the original or the copy) will be visible through the other, leading to unintended side effects and a lack of data independence.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('a2f68fad-3ac8-4993-bc77-0609d22b32c0', 'This explains that deep copies ensure full independence by creating new instances of all nested objects, preventing side effects unlike shallow copies.', 'The primary advantage of a deep copy is that it ensures **complete data independence** between the original object and its copy. By recursively duplicating all nested objects, a deep copy creates new instances for every component, meaning changes made to the copied object or its nested parts will not affect the original object, and vice versa. This prevents unexpected side effects.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('41aeda21-168e-4dd7-97c3-f0491ac8a384', 'This explanation highlights how immediate initialisation by constructors prevents unpredictable states and potential errors.', 'Constructors initialise an object''s essential attributes upon creation. This prevents the object from being used with unassigned or unpredictable values, which could lead to errors or unstable behaviour.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('9a167ae3-3a6f-42e5-9f40-493df46ff3ca', 'This example shows a constructor setting default values for a new object''s attributes, ensuring a defined and usable state from creation.', '```java
class Product {
    String name;
    double price;

    public Product() {
        this.name = "Unnamed Product";
        this.price = 0.0;
    }
}
```
In this example, the `Product()` constructor automatically sets `name` to "Unnamed Product" and `price` to `0.0` when a `Product` object is created. This ensures that every new product object starts with defined, valid default values, making it stable and ready for use without containing undefined data.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('86dde6ab-12aa-401c-b92d-83160d21be07', 'Java, .NET, and Swift are programming languages that have been designed to avoid the complexities of direct multiple inheritance, opting for other mechanisms like interfaces for behavioral inheritance.', 'Java and .NET (or Swift). Any two of these are acceptable answers.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('697a8302-de94-48d7-acd2-9e6194b8a514', 'Languages like Java and .NET use **interfaces** to enable classes to inherit behaviours without the complexity associated with inheriting implementation from multiple parent classes.', 'Interfaces.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('2ef714e8-f94a-4511-a648-9871b1642982', 'Designing with multiple inheritance involves balancing its potential advantages, such as code reuse, against the increased complexity and potential design issues it introduces. Practical considerations, like specific language support, are also part of the evaluation.', 'The evaluation requires weighing the **benefits** against the **added complexity** and also considering **which languages support it**.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('3b648229-1ae9-44b0-b110-795144560724', 'Constructor overloading provides different initialization paths (default or custom values) by allowing multiple constructors with varying parameters, making object creation adaptable to available data.', 'Constructor overloading allows a class to define multiple ways to instantiate its objects, each tailored to different sets of initial data. This flexibility means objects can be created with **default values** when no specific data is provided, or with **custom values** when data is available, enabling various initialisation paths.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('76c987e8-8ced-4eca-a880-d0c4c7c022bd', 'The compiler selects the constructor whose distinct signature (number and types of parameters) exactly matches the arguments provided during object instantiation. In this case, a single String argument matches the `Product(String name)` constructor.', '```java
public class Product {
    String name;
    double price;

    public Product() {
        this.name = "Unnamed Product";
        this.price = 0.0;
    }

    public Product(String name) {
        this.name = name;
        this.price = 0.0;
    }
}

// Line of code to instantiate:
Product myProduct = new Product("Laptop");
```

**Explanation:** The compiler chooses `public Product(String name)` because the instantiation `new Product("Laptop")` provides a **single `String` argument**. This argument''s type and count perfectly match the parameters of that specific constructor''s signature.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('cba2963d-4aa1-4c97-9e43-f7122cff4c55', 'The class is contractually bound to implement all abstract methods from the interface, guaranteeing it provides the specified functionalities and can be used wherever that interface is expected.', 'When a concrete class implements an interface, it enters a contract requiring it to **provide a concrete implementation for every abstract method** declared in that interface. This ensures the class fulfills all the functionalities specified by the interface.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('9773f4f2-0c18-47d0-8c18-a566e51a2353', 'The snippet shows the `Resettable` interface defining a contract. The `Counter` class implements this interface and provides a concrete body for the `reset()` method, thus adhering to the contract.', '```java
interface Resettable {
    void reset();
}

class Counter implements Resettable {
    private int count;

    public Counter() {
        this.count = 0;
    }

    @Override
    public void reset() {
        // Concrete implementation for resetting the counter
        this.count = 0;
        System.out.println("Counter reset to 0.");
    }

    public void increment() {
        this.count++;
    }

    public int getCount() {
        return this.count;
    }
}
```

**Explanation**: The `Resettable` interface defines a contract with one abstract method, `reset()`. The `Counter` class **implements** this interface. It fulfills its contract by providing a **concrete implementation** for the `reset()` method, setting its internal `count` to zero and printing a message.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('328b76e2-e5bf-40f2-b932-55035adbd3ed', 'This explanation clarifies the memory allocation and access patterns distinguishing object and class scope.', '**Object-scoped** attributes (instance variables) have memory allocated for each object instance, meaning every object has its own unique copy. They are typically accessed using an object''s reference (e.g., `myObject.attribute`). **Class-scoped** attributes (static variables) have a single memory location shared by all objects of that class. They are typically accessed directly via the class name (e.g., `MyClass.attribute`).');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('dc44054b-3fe5-4c01-adc7-46b10405247d', 'This highlights how scope limits access, protecting data from corruption and aiding in maintainability.', 'Proper scope ensures **data integrity** by strictly controlling access to attributes. By limiting variables to the smallest possible scope (e.g., local for temporary use, `private` for object state), unintended modifications from unrelated parts of the program are prevented, making data reliable and debugging easier.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('7c0e8f4c-e63b-43c5-ad93-357c4ab22a43', 'The explanation differentiates between a method parameter (local) and an instance variable (object) based on their declaration and lifetime.', '```java
class Cabbie {
    private int totalTrips; // Attribute

    public Cabbie(String cabbieName) { // Parameter
        this.totalTrips = 0;
        // Further logic
    }
}
```

*   `cabbieName`: This is a **local scope** attribute. It is a parameter of the constructor method and only exists during the execution of that specific constructor call.
*   `totalTrips`: This is an **object scope** attribute. It is declared directly within the `Cabbie` class but outside any method, meaning each `Cabbie` object instantiated will have its own independent `totalTrips` value.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('b4a79808-a9d4-46f5-9ba6-3481a5605a93', 'This explanation addresses both the benefit (intuitive syntax) and the pitfall (confusion, maintenance issues) of operator overloading when used improperly.', 'Operator overloading allows developers to redefine standard operators for custom types, which can make syntax intuitive. However, if used indiscriminately, it can make code confusing because an operator''s behaviour might deviate from its widely understood meaning, leading to unexpected results and making debugging and maintenance difficult.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('16d2527d-07b4-463d-9fc9-6065d521edab', 'The example demonstrates how the `+` operator''s behaviour is customised for `String` objects, showing its dual purpose beyond just numeric operations.', '```java
String firstName = "Alice";
String lastName = "Smith";
String fullName = firstName + " " + lastName;
System.out.println(fullName); // Output: Alice Smith
```
This example illustrates operator overloading because the `+` operator, typically used for numeric addition, is redefined here to perform string concatenation when applied to `String` objects.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('868a1f17-d5d3-43fd-85cc-c3de38d12038', 'Attributes store data that defines an object''s state, while methods encapsulate the operations or behaviors that an object can perform.', 'An **attribute** (or data) represents the **state** or characteristics of an object, storing information like its properties or values. A **method** (or behavior) defines the **actions** an object can perform or the operations it can execute on its data.
```java
class Person {
    String name; // Attribute: stores the person''s name
    void introduce() { // Method: defines an action
        System.out.println("My name is " + name + ".");
    }
}
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('d054bcd5-05ee-421d-85e5-e73754034061', 'The interface is the contract for how to use a method, represented by its signature. The implementation is the internal logic, contained within the method''s body, that fulfils that contract.', 'In the provided `Calculator` example:

- The **method''s interface** is its signature: `public int add(int a, int b)`. This part tells other objects how to interact with the `add` method, specifying its name, parameters, and return type.
- The **method''s implementation** is the code within its curly braces (`{...}`): `int sum = a + b; return sum;`. This is the actual logic that defines how the `add` method performs the addition operation.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('3384c462-7cdf-46b6-b83f-dc571709a61b', 'Interfaces establish a contract for behavior. When different classes adhere to this contract, code written against the interface can interact with any of these classes polymorphically, promoting generality.', 'Interfaces enable polymorphism by providing a common type definition that multiple unrelated classes can implement. This allows generic code to be written to the interface type, rather than specific concrete classes. When this generic code executes, the actual method implementation invoked depends on the concrete object passed at runtime, allowing various implementing classes to be handled interchangeably through a single code path.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('504c44c2-7371-4b99-be54-a988c211ea39', 'This demonstrates the benefit of separating interface from implementation. A stable interface acts as a contract, allowing the underlying implementation to evolve without disrupting consuming code.', 'If a method''s internal logic (implementation) changes but its signature (interface) remains the same, other parts of the codebase using this method are **unaffected**. This is significant because it supports **code maintainability and flexibility**, allowing internal improvements or bug fixes without requiring changes or recompilations in dependent code.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('0962e7e2-ca97-48ec-a9c0-8aa87f4cf573', 'Programming to an interface effectively ''hides'' the implementation details from the client. This separation ensures that internal changes to one component do not necessitate changes in others, leading to a more robust and adaptable software system.', 'The `ReportGenerator` class would experience **no impact** or **minimal impact**. It would **not require modification or recompilation**. This is because the `ReportGenerator` interacts solely with the `IDataSource` interface, which acts as a stable contract. As long as the new `WebServiceDataSource` implementation adheres to this interface, the `ReportGenerator` remains unaware of the change in the underlying data fetching mechanism. This is highly significant in software design as it demonstrates **loose coupling**, **improved maintainability**, and **enhanced extensibility**, allowing changes to specific components without rippling across the entire system.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('bef352b7-824a-45af-877e-74c4eb0e996d', 'Interfaces allow for writing highly adaptable and extensible code. By programming to an interface, new concrete implementations can be introduced without altering the client code, improving maintainability and flexibility.', 'Interfaces enhance **flexibility** by allowing different concrete classes to implement a common interface, enabling code to interact with these objects via the interface type rather than their specific classes. This means new classes implementing the interface can be added without modifying existing code that uses the interface. For example, a method designed to process an `interface Payable` can work with both `Employee` and `Contractor` objects, provided both classes implement `Payable`.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('265e1cb3-2a86-410b-bf9f-a8b7983311b2', '`Private` attributes protect an object''s internal state from external manipulation, ensuring that data is valid and managed only through defined, controlled methods. This design also reduces the exposed interface of the class.', 'Declaring attributes as **`private`** restricts direct external access, meaning only methods within the same class can access or modify them. This enhances **data integrity** by preventing uncontrolled changes from outside the class, allowing the class to enforce validation rules through accessor methods (getters and setters). It supports a **minimal interface** by hiding internal data details, exposing only necessary functionality through public methods, which reduces complexity for external users.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('6d635e86-f2fb-44a6-8e10-cbdd7ef21f5c', 'Loose coupling reduces dependencies between components, making a system more modular, flexible, and easier to maintain. Programming to an interface creates a flexible point where different implementations can be swapped in without affecting the code that uses the interface.', 'Designing with interfaces promotes loose coupling because client code interacts with an abstract contract (the interface) rather than a specific concrete class. This means that the underlying implementation can be changed or replaced without requiring modifications to the client code, as long as the new implementation adheres to the defined interface. For example, a `CustomerService` class could depend on an `ICustomerRepository` interface. If the data storage changes from a SQL database to a NoSQL database, only the concrete `CustomerRepository` implementation needs updating, not the `CustomerService` or other parts of the application that use the `ICustomerRepository` interface.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('711196d2-c155-40e7-84a9-eedee40b882a', 'The `makeAnyAnimalSound` method''s ability to call `makeSound()` on different `Animal` implementations demonstrates polymorphism, as the specific behavior is determined at runtime by the object''s actual type.', '```java
interface Animal {
    void makeSound();
}

class Dog implements Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}

class Cat implements Animal {
    @Override
    public void makeSound() {
        System.out.println("Meow");
    }
}

public class Zoo {
    public static void makeAnyAnimalSound(Animal a) {
        a.makeSound();
    }

    public static void main(String[] args) {
        Dog myDog = new Dog();
        Cat myCat = new Cat();

        makeAnyAnimalSound(myDog); // Calls Dog''s makeSound()
        makeAnyAnimalSound(myCat); // Calls Cat''s makeSound()
    }
}
```
This example shows polymorphism because the `makeAnyAnimalSound` method accepts an `Animal` interface argument. Despite being generic, it correctly invokes the specific `makeSound()` implementation (Woof or Meow) based on the concrete `Dog` or `Cat` object passed at runtime.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('b02e77db-a2d3-441e-89ea-f993d82a0ba7', 'A `static` attribute is shared by all instances of a class, holding a single value for the entire class, while instance attributes hold unique values for each object.', 'A **`static` attribute** is a variable that belongs to the class itself, rather than to any specific instance (object) of that class. This means there is only **one single copy** of the `static` attribute, shared by all objects created from that class. In contrast, a **non-static (instance) attribute** has a separate copy for **each individual object**.
```java
class Car {
    String model; // non-static (instance) attribute
    static int numberOfCarsCreated = 0; // static attribute

    public Car(String model) {
        this.model = model;
        numberOfCarsCreated++;
    }

    public void displayInfo() {
        System.out.println("Model: " + this.model + ", Total Cars: " + numberOfCarsCreated);
    }
}
```');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('bfe72beb-d220-40a0-854a-d129979a2d89', 'Interfaces specify methods that implementing classes must define, focusing on standardising behaviours (the "what") rather than providing concrete code (the "how").', 'An interface defines **what** a class should do by specifying abstract methods (their signatures), but not **how** it should do it (their code bodies). It acts as a contract, ensuring that any class implementing it will provide its own specific implementation for those methods. This promotes abstraction by separating the definition of a behaviour from its concrete execution.');
INSERT INTO public.written_questions (question_id, answer_explanation, correct_answer_text) VALUES ('46e76d0c-a956-47d0-aa16-08b2e36ea235', 'Interfaces achieve abstraction by separating method declarations from their implementations. They standardise functionality by requiring all implementing classes to provide definitions for a common set of methods, enabling consistent interaction.', 'Interfaces promote **abstraction** by defining a common contract for behaviour (what methods a class *should* have) without exposing the internal implementation details (how those methods work). This allows different classes to implement the same interface, thereby **standardising functionality**. For example, defining `interface Shape { double calculateArea(); }` means all classes like `Circle` or `Square` must implement `calculateArea()`, allowing them to be treated uniformly through the interface while each provides its unique area calculation logic.');


--
-- PostgreSQL database dump complete
--

\unrestrict 93BEPnLoz40z26UXYtQrRvNlYuxnDrGhMYlEMkaZTnMltwimC5rCCycL1uHq6vs

