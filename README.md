# GLPI — Gestion des incidents et automatisation sur Windows Server

Projet pratique réalisé dans le cadre de ma formation à **SUPINFO** (module *Windows Server and Cybersecurity Fundamentals*).

## Présentation

L'objectif du projet est de déployer **GLPI 11** pour gérer les demandes d'assistance informatique, inventorier les postes et automatiser la création de tickets en cas de manque d'espace disque.

L'infrastructure a été réalisée dans un environnement de laboratoire avec **VMware Workstation**.

## Environnement technique

| Machine virtuelle | Système | Rôle |
| --- | --- | --- |
| GLPI-SRV | Windows Server 2025 | GLPI 11, IIS, PHP/FastCGI, MariaDB |
| GLPI-SRV2 | Windows Server 2025 | Active Directory, DNS, AD CS |
| GLPI-CLIENT | Windows 11 | Poste utilisateur, GLPI Agent, script PowerShell |

**Technologies :** Windows Server 2025, Windows 11, VMware Workstation, IIS, PHP, MariaDB, GLPI 11, Active Directory, DNS, AD CS, HTTPS, LDAPS, PowerShell, API REST et OAuth.

## Réalisations

- Installation et configuration de **GLPI 11** sur IIS avec PHP/FastCGI et MariaDB.
- Configuration du domaine Active Directory et de la résolution DNS.
- Sécurisation de l'accès au site avec un certificat émis par **AD CS** et redirection HTTP vers HTTPS.
- Connexion de GLPI à Active Directory via **LDAPS** et importation des utilisateurs.
- Installation de **GLPI Agent** et vérification de l'inventaire du poste Windows 11.
- Mise en place des profils **Technician** et **Self-Service** pour la gestion des demandes.
- Développement d'un script **PowerShell** qui vérifie l'espace libre des disques et crée un ticket via l'**API REST de GLPI** et une authentification **OAuth** si l'espace libre est inférieur ou égal à **5 %**.
- Exécution automatique du contrôle toutes les **15 minutes** avec le Planificateur de tâches Windows.

## Tests et résultats

J'ai testé le fonctionnement de GLPI, l'accès HTTPS, l'importation des comptes Active Directory et l'inventaire du poste client.

Pour vérifier l'automatisation, j'ai ajouté un disque virtuel de 2 Go au poste Windows 11 et réduit son espace libre sous le seuil de 5 %. Le script PowerShell a alors créé automatiquement un ticket GLPI indiquant le poste, le disque et le pourcentage d'espace libre.

## Difficultés rencontrées

Le projet m'a également permis de résoudre plusieurs problèmes de configuration :

- Erreur HTTP **403.14** et configuration de `web.config` pour IIS.
- Droits **NTFS** nécessaires au fonctionnement de GLPI.
- Configuration **OpenSSL** pour la génération des clés.
- Vérification du certificat de confiance pour la connexion **LDAPS**.
- Utilisation des jetons **OAuth** et des requêtes HTTP pour créer des tickets via l'API.

## Documentation

Le rapport technique détaille l'architecture, les principales étapes de configuration, les difficultés rencontrées et les tests effectués, avec des captures d'écran.

📄 **[Consulter le rapport technique (PDF)](Projet_GLPI.pdf)**

---

*Projet pédagogique réalisé dans un environnement de laboratoire, non destiné à une utilisation en production.*
