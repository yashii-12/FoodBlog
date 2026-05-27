CREATE DATABASE food_blog;
USE food_blog;

CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    ingredients TEXT,
    instructions TEXT,
    image VARCHAR(255),
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT,
    username VARCHAR(100),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(recipe_id) REFERENCES recipes(id)
);

INSERT INTO admins(username,password)
VALUES('myk','myk@123');
INSERT INTO categories(category_name)
VALUES('Desserts'),('Junk Food'),('Healthy Food'),(' Beverages'),('Non-Vegetarian'),('Vegetarian');
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Chocolate Cake','A delicious chocolate cake recipe.','Flour, Sugar, Cocoa Powder, Eggs, Butter','1. Preheat oven to 350°F (175°C). 2. Mix dry ingredients. 3. Add wet ingredients and mix well. 4. Pour into a greased pan and bake for 30-35 minutes.','https://nourishingamy.com/wp-content/uploads/2023/09/Chocolate-Hazelnut-Fudge-Cake-2-683x1024.jpg',1);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Cheeseburger','A classic cheeseburger recipe.','Ground beef, Cheese, Lettuce, Tomato, Bun','1. Form ground beef into patties. 2. Grill or pan-fry until cooked to desired doneness. 3. Add cheese on top and let it melt. 4. Assemble the burger with lettuce, tomato, and bun.','https://i.pinimg.com/originals/3b/6c/c6/3b6cc651e4cd1cbc7fa7d559a5b81810.jpg',2);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Chicken Biryani','A flavorful and aromatic chicken biryani recipe.','Chicken breast, Basmati rice, Mixed spices, Yogurt, Onions','1. Marinate chicken with yogurt and spices. 2. Cook basmati rice separately. 3. Layer marinated chicken and cooked rice in a pot. 4. Bake until fragrant and well combined.','https://butteroverbae.com/wp-content/uploads/2020/10/karachi-chicken-biryani-11.jpg',5);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Chocolate Milkshake','A rich chocolate milkshake recipe.','Chocolate syrup, Milk, Ice cream','1. In a blender, combine chocolate syrup, milk, and ice cream. 2. Blend until smooth and creamy. 3. Pour into a glass and serve immediately.','https://iambaker.net/wp-content/uploads/2024/06/Chocolate-Shake-2-800x1219.jpg',4);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)   
VALUES('Pasta Primavera','A light and fresh pasta primavera recipe.','Pasta, Mixed vegetables, Olive oil, Garlic, Parmesan cheese','1. Cook pasta according to package instructions. 2. In a pan, sauté garlic and mixed vegetables in olive oil until tender. 3. Toss cooked pasta with the sautéed vegetables. 4. Sprinkle with Parmesan cheese and serve.','https://cooktoria.com/wp-content/uploads/2019/10/one-pot-pasta-11-360x539.jpg',3);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Cheese Cake','A classic cheese cake recipe.','Cream cheese, Sugar, Eggs, Vanilla extract','1. Preheat oven to 350°F (175°C). 2. Cream together cream cheese and sugar. 3. Add eggs and vanilla extract and mix well. 4. Pour into a greased pan and bake for 45-50 minutes.','https://recipessmile.com/wp-content/uploads/2025/05/Creamy-Baked-Cheesecake.png',1);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Veggie Stir-Fry','A quick and easy veggie stir-fry recipe.','Mixed vegetables, Soy sauce, Garlic, Ginger, Olive oil','1. Heat olive oil in a pan. 2. Add garlic and ginger and sauté for a minute. 3. Add mixed vegetables and stir-fry until tender. 4. Drizzle with soy sauce and serve over rice or noodles.','https://www.thecookierookie.com/wp-content/uploads/2023/04/vegetable-stir-fry-recipe-3-edited-650x867.jpg',3);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Margherita Pizza','A simple and delicious margherita pizza recipe.','Pizza dough, Tomato sauce, Fresh mozzarella, Basil leaves, Olive oil','1. Preheat oven to 475°F (245°C). 2. Roll out pizza dough on a floured surface. 3. Spread tomato sauce over the dough. 4. Top with fresh mozzarella and basil leaves. 5. Drizzle with olive oil and bake for 10-12 minutes until crust is golden and cheese is bubbly.','https://tse2.mm.bing.net/th/id/OIP.AfztYuMKFWwZdZwonbrr_QHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',2);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Fruit Salad','A refreshing fruit salad recipe.','Mixed fruits, Honey, Lime juice','1. Chop mixed fruits into bite-sized pieces. 2. In a small bowl, whisk together honey and lime juice. 3. Drizzle the honey-lime dressing over the chopped fruits and toss gently to combine. 4. Serve chilled.','https://www.barefootfarmbyron.com/wp-content/uploads/2023/09/delicious-breakfast-fruit-salad-recipe-start-your-day-with-a-burst-of-freshness-1.jpg',4);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('pancakes','Fluffy pancakes recipe.','Flour, Milk, Eggs, Baking powder, Sugar','1. In a bowl, mix flour, baking powder, and sugar. 2. In another bowl, whisk together milk and eggs. 3. Combine wet and dry ingredients and mix until just combined. 4. Heat a griddle or pan and pour batter to form pancakes. 5. Cook until bubbles form on the surface, then flip and cook until golden brown. Serve with syrup or toppings of choice.','https://svetb.com/wp-content/uploads/2025/02/Image_3-89.png',1);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Chicken Curry','A flavorful chicken curry recipe.','Chicken, Curry powder, Coconut milk, Onion, Garlic, Ginger','1. Heat oil in a pan and sauté onion, garlic, and ginger until fragrant. 2. Add chicken pieces and cook until browned. 3. Stir in curry powder and cook for a minute. 4. Pour in coconut milk and simmer until chicken is cooked through and sauce has thickened. 5. Serve with rice or naan bread.','https://i.pinimg.com/originals/9f/a3/fb/9fa3fb041dcb9d3166e6e8fdc1996d96.png',5);   
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Vegetable Soup','A comforting vegetable soup recipe.','Mixed vegetables, Vegetable broth, Onion, Garlic, Olive oil, Herbs','1. Heat olive oil in a large pot and sauté onion and garlic until softened. 2. Add mixed vegetables and cook for a few minutes. 3. Pour in vegetable broth and bring to a boil. 4. Reduce heat and simmer until vegetables are tender. 5. Season with herbs, salt, and pepper to taste. Serve hot.','https://northshore.noveltysweets.co.nz/wp-content/uploads/2021/08/Hot-Sour-Soup.jpg',3);
INSERT INTO recipes(title,description,ingredients,instructions,image,category_id)
VALUES('Honey Glazed Carrots','A sweet and savory honey glazed carrot recipe.','Carrots, Honey, Butter, Salt, Pepper','1. Peel and cut carrots into sticks. 2. In a pan, melt butter and add carrots. 3. Drizzle with honey and season with salt and pepper. 4. Cook until carrots are tender and glazed.','https://www.modernhoney.com/wp-content/uploads/2016/11/Honey-Glazed-Carrots-1-1200x959.jpg',3);
INSERT INTO blogs(title,content)
VALUES('My First Blog Post','This is the content of my first blog post.');
INSERT INTO comments(recipe_id,username,comment)
VALUES(1,'Manu','This chocolate cake recipe is amazing! I tried it and it turned out great.');

CREATE TABLE contact_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    message TEXT
);

CREATE TABLE blogs (

    id INT PRIMARY KEY AUTO_INCREMENT,

    title VARCHAR(255),

    content TEXT,

    image VARCHAR(500),

    author VARCHAR(100),

    created_at TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP

);

INSERT INTO blogs
(
    title,
    content,
    image,
    author
)

VALUES
(
    'My First Blog',
    'This is my first food blog post.',
    'https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg?cs=srgb&dl=appetizer-bowl-delicious-1640772.jpg&fm=jpg',
    'Admin'
);

CREATE TABLE contact_messages (

    id INT PRIMARY KEY AUTO_INCREMENT,

    name VARCHAR(100),

    email VARCHAR(100),

    message TEXT,

    created_at TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP

);

INSERT INTO contact_messages
(
    name,
    email,
    message
)
VALUES
(
    'Manu',
    'manu@email.com',
    'Hello, I would like to know more about your food blog!'
);

CREATE TABLE users (

    id INT AUTO_INCREMENT PRIMARY KEY,

    username VARCHAR(100),

    email VARCHAR(150),

    password VARCHAR(255)

);
INSERT INTO users
(
    username,
    email,
    password    
)
VALUES
(
    'manu',
    'manu@email.com',
    'hashed_password_here'
);