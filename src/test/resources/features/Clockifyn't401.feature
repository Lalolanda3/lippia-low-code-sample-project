@Clockifynt401 @Test
Feature: error 401 en el registro de horas

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = OThhZGUxZtYTI3OGEyZDBkZTA5

  @GetWorkspace
  Scenario: Obtener los workspace
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    And validate schema workspaces.json


  @AddProject
  Scenario: Crear un nuevo proyecto
    Given call Clockify.feature@GetWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And body project.json
    When execute method POST
    Then the status code should be 201

  @GetProjects
  Scenario: Obtener todos los proyectos de un Workspace
    Given call Clockify.feature@GetWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200



  @GetTimeEntry401
  Scenario: Error 401 por mala API key
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 401

  @AddHours401
  Scenario: Error 401 por mala API key
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    And body hours.json
    When execute method POST
    Then the status code should be 401

  @EditTimeEntry401
  Scenario: Error 401 por mala API key
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    And body time.json
    When execute method PUT
    Then the status code should be 401

  @DeleteTimeEntry401
  Scenario: Error 401 por mala API key
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    When execute method DELETE
    Then the status code should be 401


