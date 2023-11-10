# Lippia API Lowcode v1.0 @_Unreleased_

[![Crowdar Official Page](https://img.shields.io/badge/crowdar-official%20page-brightgreen)](https://crowdar.com.ar/)
[![Lippia Official Page](https://img.shields.io/badge/lippia-official%20page-brightgreen)](https://www.lippia.io/)
<!-- [![Maven Central](https://img.shields.io/badge/maven%20central-3.2.3.8-blue)](https://search.maven.org/artifact/io.lippia/core/3.2.3.8/jar) -->

#### **Lippia AC** is a core level extension that allows us to automate api tests without the need to write code

## Requirements

+ **JDK** [Download](https://www.oracle.com/java/technologies/downloads/#java8-windows)
+ **Maven** [Download](https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip)
+ **Git
  Client** [Download](https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe)

## Getting Started

```bash
$ git clone https://github.com/Crowdar/lippia-low-code-sample-project.git && cd "$(basename "$_" .git)"

```

#### Once the project is cloned and opened with your preferred ide, we can run the tests with the following command

```bash
$  mvn clean test -Dcucumber.tags=@Sample -Denvironment=default
```


## Contents

1. [Variables](##Variables)    
   I. [Define](###I.Define)
2. [Properties](../path/to/properties)   
   I. [Lippia configuration file](#Lippia Configuration file)   
   II. [Basic properties file](../path/to/properties)
3. [Requests](../path/to/requests)   
   I. [Base URL](##I.BaseURL)   
   II. [Endpoint](##II.Endpoint)   
   III. [Headers](##III.Headers)   
   IV. [Body](##IV.Body)   
   V. [HTTP Method](#HTTP Method)
4. [Assertions](#Assertions)   
   I. [Status code](##I.Status Code)
   II. [JSON](##II.JSON)
5. [Steps Glossary](##StepsGlossary)

## Variables

### I. Define

#### In order to define a variable and assign it with a constant value or a variable value use :

      * define [^\d]\S+ = \S+
      * define codigo = 7000

#### So that you need to call the previously defined variable, use double brackets :

### For example

       Given body body_request_1700.json
       * define codigo = 7000
       When execute method POST
       Then the status code should be 400
       And response should be $.code = {{codigo}}

--------------------------------------------------------------

#### alternatively you could use the value obtained from a response :

      Given body body_request_1700.json
      When execute method POST
      Then the status code should be 200
      And response should be $.code = 7114
      * define codigo = $.code

--------------------------------------------------------------

## Lippia Configuration file

### (lippia.config)

```
├── automation-reestructuracion-gateway
│   │   
│   ├── src
│   │   ├── main
│   ├── java
│   │     └── ...
│   ├── resources 
│   │     └── ...
│   ├── test
│   │     ├── resources
│   │     │   └── features
│   │     │   └── files
│   │     │   └── jsons
│   │     │   |    └──bodies
│   │     │   |    └── ...
│   │     │   └── queries
│   │     │   └── ...
│   │     │   └── extent.properties
│   │     │   └── lippia.conf
```

#### In this file you can specify the base url of the different environments, such as development, integration or testing :

```
environments {
    default {
        "base.url" = "https://www.by.default.com"
    }

    dev {
        "base.url" = "https://www.dev-by.default.com"
    }

    test {
        "base.url" = "https://www.test-by.default.com"
    }

    prod {
        "base.url" = "https://www.?by.default.com"
    }
}
```

#### The environments can  be changed from the command line by referencing the respective environment by its name.

### For example

     -Denvironment=test

## Enviroment Manager

#### To obtain data from the Environment manager we use the following method, in this case it is not allowed to obtain the base url

      EnvironmentManager.getProperty("base.url")

--------------------------------------------------------------

## I.Base URL
####The base url can be defined by the following step, it is simply to replace the regular expression /\+S by the url :

### For example
      base url \S+
      Given base url https://rickandmortyapi.com/api/


####Alternatively we can use the following notation, if we have defined the url in the lippia.conf file


      Given base url env.base_url_rickAndMorty


--------------------------------------------------------------

## II.Endpoint

#### You can easily replace the endpoint value in the regular expression of the "\S+" step :

       endpoint \S+

### For example

      Given base url https://url-shortener-service.p.rapidapi.com
      And endpoint shorten

---------------------------------------------------------------------------------

## III.Headers

#### You can set a header just by defining the step and filling the key and the value as many times as you need to do it :

      And header \S+ = \S+

### For example

      And header Content-Type = application/json
      And header key = value

---------------------------------------------------------------------------------

## IV.Body

```
├── automation-reestructuracion-gateway
│   │   
│   ├── src
│   │   ├── main
│   ├── java
│   │     └── ...
│   ├── resources 
│   │     └── ...
│   ├── test
│   │     ├── resources
│   │     │   └── features
│   │     │   └── files
│   │     │   └── jsons
│   │               └──bodies
│   │               └── ...
│        
```

#### You can reference a json file created in the default location (jsons/bodies folder) :

      Given body \S+

### For example

     Given body name_file.json

#### Or you can create a new folder inside it :

    Given body new_folder/name_file.json

---------------------------------------------------------------------------------

- ## HTTP Method

#### The HTTP Methods supported by steps are : GET | POST | PUT | PATCH | DELETE

### For example

     When execute method POST

---------------------------------------------------------------------------------

- # Assertions

## I. Status Code

#### The step to assert the HTTP response code is as follows :

         the status code should be <number>

### For example

         Then the status code should be 200

#### If the HTTP response code is anything other than what is expected, this assertion will result in the test failing.

## II. JSON

#### You can make assertions on any attribute of the obtained response, whether it's integer, float, double, string, or boolean value by referencing it by its name :

### For example

      And response should be name = Rick Sanchez

### Another way to reference it is by prepending "$." before the attribute name :

       And response should be $.status = Alive

### Schemas

```
├── automation-reestructuracion-gateway
│   │   
│   ├── src
│   │   ├── main
│   ├── java
│   │     └── ...
│   ├── resources 
│   │     └── ...
│   ├── test
│   │     ├── resources
│   │     │   └── features
│   │     │   └── files
│   │     │   └── jsons
│   │               └── ...
│   │               └── ...
│   │               └── ...
│   │               └── ...
│   │               └── schemas
|
│        
```

#### You can create a schema file with ".json" extension at the directory mentioned above (jsons/schemas folder).

### For example

         And validate schema character.json

## Steps Glossary

| ENGLISH                                                              | SPANISH                                                           |
|:---------------------------------------------------------------------|:------------------------------------------------------------------|
| add query parameter '\<any>' = \<any>                                                | agregar parametro a la query '\<any>' = \<any>                    |
| base url \S+                                                                                  | base url \S+                                                      |
| body \S+                                                                                      | body \S+                                                          |
| call \S+.feature[@:\$]\S+                                                            | invocar \S+.feature[@:\$]\S+                                      |
| create connection database '\<any>'                                                  | crear conexion a la base de datos '\<any>'                        |
| define [^\d]\S+ = \S+                                                                        | definir  [^\d]\S+ = \S+                                           |
| delete keyValue \<any> in body \<any>                                                | eliminar clave \<any> en el  body \<any>                          |
| endpoint \S+                                                                                  | endpoint \S+                                                      |
| execute method GET l POST l PUT l PATCH l DELETE                         | ejecutar metodo GET l POST l PUT l PATCH l DELETE                 |
| execute query '\<any>'                                                                     | ejecutar query '\<any>'                                           |
| header \S+ = \S+                                                                            | header \S+ = \S+                                                  |
| And I save from result JSON the attribute <any> on variable <any>          | guardo del resultado JSON el atributo <any> en la variable \<any> |
| param \S+ = \S+                                                                                | param \S+ = \S+                                                   |
| response should be [^\s].+ = [^\s].*                                                   | la respuesta debe ser [^\s].+ = [^\s].*                           |
| response should be [^\s].+ contains [^\s].*                                         | la respuesta debe ser [^\s].+ contiene [^\s].*                    |
| set value \<any> of key \<any> in body \<any>                                       | setear el valor \<any> de la clave \<any> en el body \<any>       |
| the status code should be \<number>                                                    | el status code debe ser \<number>                                 |
| validate field '\<any>' = \<any>                                                          | validar el campo '\<any>' = \<any>                                |
| validate schema \<string>                                                                 | validar schema \<string>                                          |



