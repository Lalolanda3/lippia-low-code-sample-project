@Clockifynt404 @Test
Feature: error 404 en el registro de horas

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



  @GetTimeEntry404
    Scenario: Error 404 por endpoint erroneo
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}
    When execute method GET
    Then the status code should be 404

  @AddHours404
  Scenario: Error 404 por endpoint erroneo
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/{{userId}}/time-entries
    And body hours.json
    When execute method POST
    Then the status code should be 404

  @EditTimeEntry404
  Scenario: Error 404 por endpoint erroneo
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v2/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    And body time.json
    When execute method PUT
    Then the status code should be 404

  @DeleteTimeEntry404
  Scenario: Error 404 por endpoint erroneo
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-ent
    When execute method DELETE
    Then the status code should be 404


