@Clockify @Test
Feature: clockify

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
    * define workspaceId = $.[0].id

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
    * define projectId = $.[0].id
    * define userId = $.[0].memberships[0].userId


  @GetTimeEntry
  Scenario: Obtener un registro de horas del Workspace
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 200
    * define timeId = $.[0].id

  @AddHours
  Scenario: Añadir horas a un proyecto del workspace
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    And body hours.json
    When execute method POST
    Then the status code should be 201

  @EditTimeEntry
  Scenario: Editar datos de un registro de horas
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    And body time.json
    When execute method PUT
    Then the status code should be 200

  @DeleteTimeEntry
  Scenario: Eliminar un registro de horas de un proyecto
    Given call Clockify.feature@GetTimeEntry
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    When execute method DELETE
    Then the status code should be 204



