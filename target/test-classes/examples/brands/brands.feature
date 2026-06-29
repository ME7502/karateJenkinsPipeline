Feature: Parcours brand

Background: 
    * url 'https://api.practicesoftwaretesting.com/brands'

@Parcours
Scenario: Parcours brand
    * print "--------------------------------------------- POST -------------------------------------------"
    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def random_slug = faker.internet().slug()
    * def brand = 
    """
    {
        "name": "brand Mouad",
        "slug": "#(random_slug)"
    }
    """
    Given request brand
    When method post
    Then status 201
    And match response contains brand
    * def id = response.id
    * print "id created is " + id
    #ChangeBrand
    * print "--------------------------------------------- PUT -------------------------------------------"
    * def brand_changed =
    """
    {
        "name": "brand Mouad Changed",
        "slug": "#(random_slug)"
    }
    """
    Given path id
    And request brand_changed
    When method put
    Then status 200
    And match response.success == true
    #GetById
    * print "--------------------------------------------- GET -------------------------------------------"
    Given path id
    When method get
    Then status 200