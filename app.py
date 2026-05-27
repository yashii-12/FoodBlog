import mysql.connector
from flask import Flask, render_template, request, redirect, session

app = Flask(__name__)

app.secret_key = 'foodblogsecret'

# =========================
# MYSQL CONNECTION
# =========================

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="tiger",
    database="food_blog",
    port=3306
)

cursor = conn.cursor(dictionary=True, buffered=True)

# =========================
# ADMIN LOGIN
# =========================

@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():

    if request.method == 'POST':

        username = request.form['username']
        password = request.form['password']

        if username == "kym" and password == "kym@123":

            session['admin_logged_in'] = True

            return redirect('/admin')

        else:

            return render_template(
                'admin_login.html',
                error="Invalid Credentials"
            )

    return render_template('admin_login.html')

# =========================
# ADMIN DASHBOARD
# =========================

@app.route('/admin')
def admin_dashboard():

    if 'admin_logged_in' not in session:

        return redirect('/admin/login')

    query = """ SELECT recipes.*, categories.category_name FROM recipes LEFT JOIN categories ON recipes.category_id = categories.id """

    cursor.execute(query)

    recipes = cursor.fetchall()

    # TOTAL RECIPES
    cursor.execute(
        "SELECT COUNT(*) AS total_recipes FROM recipes"
    )

    total_recipes = cursor.fetchone()

    # TOTAL CATEGORIES
    cursor.execute(
        "SELECT COUNT(*) AS total_categories FROM categories"
    )

    total_categories = cursor.fetchone()

    # TOTAL COMMENTS
    cursor.execute(
        "SELECT COUNT(*) AS total_comments FROM comments"
    )

    total_comments = cursor.fetchone()

    # TOTAL MESSAGES
    cursor.execute(
        "SELECT COUNT(*) AS total_messages FROM contact_messages"
    )

    total_messages = cursor.fetchone()

    return render_template(
        'admin.html',
        recipes=recipes,
        total_recipes=total_recipes,
        total_categories=total_categories,
        total_comments=total_comments,
        total_messages=total_messages
    )

# =========================
# REGISTER
# =========================

@app.route('/register', methods=['GET', 'POST'])
def register():

    if request.method == 'POST':

        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        cursor.execute('''
            INSERT INTO users(username, email, password)
            VALUES(%s,%s,%s)
        ''', (username, email, password))

        conn.commit()

        session['user_loggedin'] = True
        session['user_id'] = cursor.lastrowid
        session['username'] = username

        return redirect('/')

    return render_template('register.html')

# =========================
# USER LOGIN
# =========================

@app.route('/login', methods=['GET', 'POST'])
def login():

    if request.method == 'POST':

        email = request.form['email']
        password = request.form['password']

        cursor.execute('''
            SELECT * FROM users
            WHERE email=%s AND password=%s
        ''', (email, password))

        user = cursor.fetchone()

        if user:

            session['user_loggedin'] = True
            session['user_id'] = user['id']
            session['username'] = user['username']

            return redirect('/')

        else:

            return render_template(
                'login.html',
                error="Invalid Email or Password"
            )

    return render_template('login.html')

# =========================
# ADD FAVORITE
# =========================

@app.route('/favorite/<int:recipe_id>')
def favorite(recipe_id):

    if 'user_loggedin' not in session:

        return redirect('/login')

    user_id = session['user_id']

    cursor.execute('''
        SELECT * FROM favorites
        WHERE user_id=%s AND recipe_id=%s
    ''', (user_id, recipe_id))

    existing = cursor.fetchone()

    if not existing:

        cursor.execute('''
            INSERT INTO favorites(user_id, recipe_id)
            VALUES(%s,%s)
        ''', (user_id, recipe_id))

        conn.commit()

    return redirect('/')

# =========================
# MY FAVORITES
# =========================

@app.route('/my-favorites')
def my_favorites():

    if 'user_loggedin' not in session:

        return redirect('/login')

    user_id = session['user_id']

    query = """
    SELECT recipes.id,
    recipes.title,
    recipes.image,
    recipes.description

    FROM favorites

    JOIN recipes
    ON favorites.recipe_id = recipes.id

    WHERE favorites.user_id=%s
    """

    cursor.execute(query, (user_id,))

    favorites = cursor.fetchall()

    return render_template(
        'favorites.html',
        favorites=favorites
    )

# =========================
# ADMIN FAVORITES
# =========================

@app.route('/admin/favorites')
def admin_favorites():

    if 'admin_logged_in' not in session:

        return redirect('/admin/login')

    query = """
    SELECT users.username,
    recipes.title,
    favorites.id

    FROM favorites

    JOIN users
    ON favorites.user_id = users.id

    JOIN recipes
    ON favorites.recipe_id = recipes.id
    """

    cursor.execute(query)

    favorites = cursor.fetchall()

    return render_template(
        'admin_favorites.html',
        favorites=favorites
    )

# =========================
# SINGLE RECIPE PAGE
# =========================

@app.route('/recipe/<int:id>')
def recipe_details(id):

    query = """ SELECT recipes.*, categories.category_name FROM recipes LEFT JOIN categories ON recipes.category_id = categories.id WHERE recipes.id=%s """

    cursor.execute(query, (id,))

    recipe = cursor.fetchone()

    return render_template(
        'recipe.html',
        recipe=recipe
    )

# =========================
# ADD RECIPE
# =========================

@app.route('/add-recipe', methods=['GET', 'POST'])
def add_recipe():

    if 'admin_logged_in' not in session:

        return redirect('/admin/login')

    if request.method == 'POST':

        title = request.form['title']
        description = request.form['description']
        ingredients = request.form['ingredients']
        instructions = request.form['instructions']
        image = request.form['image']
        category_id = request.form['category_id']

        query = """
        INSERT INTO recipes
        (
            title,
            description,
            ingredients,
            instructions,
            image,
            category_id
        )
        VALUES(%s,%s,%s,%s,%s,%s)
        """

        values = (
            title,
            description,
            ingredients,
            instructions,
            image,
            category_id
        )

        cursor.execute(query, values)

        conn.commit()

        return redirect('/admin')

    cursor.execute("SELECT * FROM categories")

    categories = cursor.fetchall()

    return render_template(
        'add_recipe.html',
        categories=categories
    )

# =========================
# EDIT RECIPE
# =========================

@app.route('/edit-recipe/<int:id>', methods=['GET', 'POST'])
def edit_recipe(id):

    if 'admin_logged_in' not in session:

        return redirect('/admin/login')

    if request.method == 'POST':

        title = request.form['title']
        description = request.form['description']
        ingredients = request.form['ingredients']
        instructions = request.form['instructions']
        image = request.form['image']
        category_id = request.form['category_id']

        query = """
        UPDATE recipes
        SET
            title=%s,
            description=%s,
            ingredients=%s,
            instructions=%s,
            image=%s,
            category_id=%s
        WHERE id=%s
        """

        values = (
            title,
            description,
            ingredients,
            instructions,
            image,
            category_id,
            id
        )

        cursor.execute(query, values)

        conn.commit()

        return redirect('/admin')

    cursor.execute(
        "SELECT * FROM recipes WHERE id=%s",
        (id,)
    )

    recipe = cursor.fetchone()

    cursor.execute("SELECT * FROM categories")

    categories = cursor.fetchall()

    return render_template(
        'edit_recipe.html',
        recipe=recipe,
        categories=categories
    )

# =========================
# DELETE RECIPE
# =========================

@app.route('/delete-recipe/<int:id>')
def delete_recipe(id):

    if 'admin_logged_in' not in session:

        return redirect('/admin/login')

    cursor.execute(
        "DELETE FROM recipes WHERE id=%s",
        (id,)
    )

    conn.commit()

    return redirect('/admin')

# =========================
# CONTACT PAGE
# =========================

@app.route('/contact', methods=['GET', 'POST'])
def contact():

    if request.method == 'POST':

        name = request.form['name']
        email = request.form['email']
        message = request.form['message']

        query = """
        INSERT INTO contact_messages
        (
            name,
            email,
            message
        )
        VALUES(%s,%s,%s)
        """

        values = (
            name,
            email,
            message
        )

        cursor.execute(query, values)

        conn.commit()

        return redirect('/')

    return render_template('client.html')

# =========================
# MESSAGES PAGE
# =========================

@app.route('/messages')
def messages():

    if 'admin_logged_in' not in session:

        return redirect('/admin/login')

    cursor.execute(
        "SELECT * FROM contact_messages ORDER BY id DESC"
    )

    messages = cursor.fetchall()

    return render_template(
        'messages.html',
        messages=messages
    )

# =========================
# ADD BLOG
# =========================

@app.route('/add-blog', methods=['GET', 'POST'])
def add_blog():

    if 'admin_logged_in' not in session:

        return redirect('/admin/login')

    if request.method == 'POST':

        title = request.form['title']
        content = request.form['content']
        image = request.form['image']
        author = request.form['author']

        query = """
        INSERT INTO blogs
        (
            title,
            content,
            image,
            author
        )
        VALUES(%s,%s,%s,%s)
        """

        values = (
            title,
            content,
            image,
            author
        )

        cursor.execute(query, values)

        conn.commit()

        return redirect('/admin')

    return render_template('add_blog.html')

# =========================
# BLOG PAGE
# =========================

@app.route('/blogs')
def blogs():

    cursor.execute(
        "SELECT * FROM blogs ORDER BY id DESC"
    )

    blogs = cursor.fetchall()

    return render_template(
        'blogs.html',
        blogs=blogs
    )

# =========================
# SINGLE BLOG PAGE
# =========================

@app.route('/blog/<int:id>')
def blog_details(id):

    cursor.execute(
        "SELECT * FROM blogs WHERE id=%s",
        (id,)
    )

    blog = cursor.fetchone()

    return render_template(
        'blog_details.html',
        blog=blog
    )

# =========================
# CLIENT HOME PAGE
# =========================

@app.route('/')
def home():

    query = """ SELECT recipes.*, categories.category_name FROM recipes LEFT JOIN categories ON recipes.category_id = categories.id """

    cursor.execute(query)

    recipes = cursor.fetchall()

    return render_template(
        'client.html',
        recipes=recipes
    )

# =========================
# ABOUT PAGE
# =========================

@app.route('/about')
def about():

    return render_template('about.html')

# =========================
# LOGOUT
# =========================

@app.route('/logout')
def logout():

    session.pop('admin_logged_in', None)

    session.pop('user_loggedin', None)

    session.pop('user_id', None)

    session.pop('username', None)

    return redirect('/')

# =========================
# RUN APP
# =========================

if __name__ == '__main__':

    app.run(debug=True)