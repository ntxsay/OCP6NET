--1 : Obtenir tous les problèmes résolus ou non (tous les produits)
CREATE PROCEDURE dbo.GetAllProblems(@IsProblemSolved BIT)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON Tickets.StatutId = Statuses.Id
    WHERE dbo.Statuses.Name = @statusName;
END
GO
-- 2 : Obtenir tous les problèmes résolus ou non pour un produit (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductProblems(@IsProblemSolved BIT, @ProductName VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
    WHERE dbo.Statuses.Name = @statusName
      AND dbo.ProductNames.Name = @ProductName;
END
GO

-- 3 : Obtenir tous les problèmes résolus ou non pour un produit (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionProblems(@IsProblemSolved BIT, @ProductName VARCHAR(255), @ProductVersion DECIMAL(10, 1))
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END
    
    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id
    WHERE dbo.Statuses.Name = @statusName
      AND dbo.ProductNames.Name = @ProductName
      AND dbo.ProductVersions.Version = @ProductVersion;
END
GO

-- 4 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductDateRangeProblems(@IsProblemSolved BIT, @ProductName VARCHAR(255), @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
    
    WHERE dbo.Statuses.Name = @statusName
      AND dbo.ProductNames.Name = @ProductName
      AND DateCreation BETWEEN @BeginDate AND @EndDate;
END
GO

-- 5 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionDateRangeProblems(@IsProblemSolved BIT, @ProductName VARCHAR(255),
                                                                  @ProductVersion DECIMAL(10, 1),
                                                                  @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END

    SELECT tickets.Id, tickets.Problem, tickets.Resolution
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id

    WHERE dbo.Statuses.Name = @statusName
      AND dbo.ProductNames.Name = @ProductName
      AND dbo.ProductVersions.Version = @ProductVersion
      AND DateCreation BETWEEN @BeginDate AND @EndDate;
END
GO

-- 6 : Obtenir tous les problèmes résolus ou non contenant une liste de mots-clés (tous les produits)
CREATE PROCEDURE dbo.GetAllProblemsKeywords(@IsProblemSolved BIT, @CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END
    
    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = @statusName
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 7 : Obtenir tous les problèmes résolu ou non pour un produit contenant une liste de mots-clés (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductProblemsKeywords(@IsProblemSolved BIT, @ProductName VARCHAR(255), @CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END
    
    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = @statusName
                    AND dbo.ProductNames.Name = @ProductName
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 8 : Obtenir tous les problèmes résolus ou non pour un produit contenant une liste de mots-clés (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionProblemsKeywords(@IsProblemSolved BIT, @ProductName VARCHAR(255),
                                                                 @ProductVersion DECIMAL(10, 1),
                                                                 @CommaDelimitedKeyword VARCHAR(255))
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id


    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = @statusName
                    AND dbo.ProductNames.Name = @ProductName
                    AND dbo.ProductVersions.Version = @ProductVersion
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 9 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (toutes les versions)
CREATE PROCEDURE dbo.GetOneProductDateRangeProblemsKeywords(@IsProblemSolved BIT, @ProductName VARCHAR(255),
                                                                   @CommaDelimitedKeyword VARCHAR(255),
                                                                   @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END
    
    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id

    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = @statusName
                    AND dbo.ProductNames.Name = @ProductName
                    AND DateCreation BETWEEN @BeginDate AND @EndDate
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO

-- 10 : Obtenir tous les problèmes rencontrés au cours d’une période donnée pour un produit contenant une liste de mots-clés (une seule version)
CREATE PROCEDURE dbo.GetOneProductVersionDateRangeProblemsKeywords(@IsProblemSolved BIT, @ProductName VARCHAR(255),
                                                                          @ProductVersion DECIMAL(10, 1),
                                                                          @CommaDelimitedKeyword VARCHAR(255),
                                                                          @BeginDate DATETIME, @EndDate DATETIME)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @statusName AS VARCHAR(255) = 'En cours';
    IF @IsProblemSolved = 1
        BEGIN
            SET @statusName = 'Résolu';
        END

    SELECT tickets.Id, tickets.Problem
    FROM dbo.Tickets AS tickets
             LEFT JOIN dbo.Statuses
                       ON tickets.StatutId = Statuses.Id
             LEFT JOIN dbo.Products
                       ON tickets.ProductId = dbo.Products.Id
             LEFT JOIN dbo.ProductNames
                       ON Products.ProductNameId = ProductNames.Id
             LEFT JOIN dbo.ProductVersions
                       ON Products.ProductVersionId = ProductVersions.Id


    WHERE EXISTS (SELECT 1
                  FROM STRING_SPLIT(@CommaDelimitedKeyword, ',') s
                  WHERE dbo.Statuses.Name = @statusName
                    AND dbo.ProductNames.Name = @ProductName
                    AND dbo.ProductVersions.Version = @ProductVersion
                    AND DateCreation BETWEEN @BeginDate AND @EndDate
                    AND tickets.Problem LIKE '%' + TRIM(s.value) + '%');
END
GO