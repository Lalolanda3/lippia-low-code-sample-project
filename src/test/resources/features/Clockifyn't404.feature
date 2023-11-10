@Clockifynt404
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

  @AddProject404
  Scenario: Crear un nuevo proyecto
    Given call Clockify.feature@GetWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/yonosoymarinero
    And body project.json
    When execute method POST
    Then the status code should be 404

  @GetProjects
  Scenario: Obtener todos los proyectos de un Workspace
    Given call Clockify.feature@GetWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @FindProject404
  Scenario: Encontrar un proyecto por su ID en un Workspace determinado
    Given call Clockify.feature@GetWorkspace
    And call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/alagrandelepusecuca/{{projectId}}
    When execute method GET
    Then the status code should be 404

  @UpdateProjectMembership404
  Scenario: Cambiar el estado de membership de un proyecto
    Given call Clockify.feature@GetWorkspace
    And call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/bluelabel
    And body membership.json
    When execute method PATCH
    Then the status code should be 404
    * validate response should be $.memberships[0].hourlyRate[0].amount = 6


