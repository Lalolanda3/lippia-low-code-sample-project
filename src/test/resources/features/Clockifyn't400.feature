@Clockifynt400 @Test
Feature: error 400 en registro de horas

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = OThhZGUxZGUtMzVkZC00ZmZlLTk0OTgtYTI3OGEyZDBkZTA5

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



  @GetTimeEntry400
  Scenario: Error 400 por mal metodo de ejecución (POST en lugar de GET)
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method POST
    Then the status code should be 400

  @AddHoursError400
  Scenario: Error 400 por no tener archivo json del body
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method POST
    Then the status code should be 400

  @EditTimeEntryError400
  Scenario: Error 400 por no tener archivo json del body
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    When execute method PUT
    Then the status code should be 400

  @DeleteTimeEntryError400
  Scenario: Error 400 por mal Id de tiempo
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{userId}}
    When execute method DELETE
    Then the status code should be 400

