Feature: creation produit

Background:
    * url 'https://api.efi-academy.com/user-api/public'
    * def Faker = Java.type('com.github.javafaker.Faker');
    * def faker = new Faker();
    * def name = faker.name().name();
    * def email = faker.internet().emailAddress();
    * def password = faker.internet().password();
    * def role = faker.number().numberBetween(0,100) > 40 ? "admin" : "user";
    * def random_price = faker.number().randomDouble(2,200,1000);
    * def random_stock = faker.number().numberBetween(10,50);
    * def user = 
        """
        {
            "name": "#(name)",
            "email": "#(email)",
            "password": "#(password)",
            "role": "#(role)"
        }
        """
    * def user_log = 
        """
        {
            "email": "#(email)",
            "password": "#(password)"
        }
        """

    * def product =
        """
        {
            "name": "#(faker.name().name())",
            "description": "#(faker.lorem().paragraph())",
            "price": #(random_price),
            "stock": #(random_stock),
            "image_url": "#(faker.avatar().image())"
        }
        """
    * def expectedStatus = user.role == 'admin' ? 201 : 403

@Login
Scenario: register -> login -> create
    
    Given path "register"
    And request user
    When method post
    # * print ("-----------------------------------------------------------------------")
    Then status 201

    #Login
    Given path "login"
    And request user_log
    When method post
    Then status 200
    And match response.success == true
    * def token = response.token


    Given path "products"
    And header Authorization = 'Bearer ' + token
    And request product
    When method post
    * print ("Price defined:  " + product.price)
    Then match responseStatus == expectedStatus