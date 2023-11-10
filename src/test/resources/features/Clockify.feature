@Clockify
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

  @FindProject
  Scenario: Encontrar un proyecto por su ID en un Workspace determinado
    Given call Clockify.feature@GetWorkspace
    And call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  @UpdateProjectMembership
  Scenario: Cambiar el estado de membership de un proyecto
    Given call Clockify.feature@GetWorkspace
    And call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/memberships
    And body membership.json
    When execute method PATCH
    Then the status code should be 200
    * validate response should be $.memberships[0].hourlyRate[0].amount = 6

  @UpdateProject
  Scenario: Actualizar un proyecto
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And body update.json
    When execute method PUT
    Then the status code should be 200

  @DeleteProject
  Scenario: Eliminar un proyecto de un Workspace
    Given call Clockify.feature@GetProjects
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method DELETE
    Then the status code should be 200




