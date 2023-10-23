workspace "SafeGuard"{

    model {
        residentUser = person "Ocupantes del Edificio" "Trabajadores y residentes que reciben notificaciones en caso de una emergencia"
        securityUser = person "Personal de Seguridad" "Responsables de monitorear el sistema de detección de emergencias"
        softwareSystem = softwareSystem "Sistema de Detección de Emergencias" "Sistema principal que proporciona la funcionalidad de detección y respuesta a emergencias en edificios" {
            singlePagApp = container "Aplicación Single-Page Personal de seguridad" "Proporciona la funcionalidad a las funciones del personal de seguridad a través de su navegador web" "JavaScript"{
                securityUser -> this "Utilizan interfaces de software para interactuar con el sistema y realizar tareas de seguridad"
            }
            mobileApp = container "Aplicación Móvil Ocupantes" "Proporciona la funcionalidad a los usuarios ocupantes a través de su dispositivo móvil" "JavaScript" "MovilA"{
                residentUser -> this "Reciben notificaciones y siguen instrucciones en caso de una emergencia"
            }
            webApp = container "Aplicación Web" "Ofrece el contenido estático y la aplicación Single-Page de SafeGuard." "TypeScript and Node.js"{
                securityUser -> this "Visita a SafeGuard.com [HTTPS]"
                singlePagApp -> this "Entrega al navegador web del cliente"
                singlePagApp -> this "Hace llamadas API a" "JSON/HTTPS"
            }
            
            apiApp = container "Aplicación API" "Proporciona funcionalidad a través de JSON/HTTPS API" "TypeScript and Nest.js"{
                singlePagApp -> this "Hace llamadas API a" "JSON/HTTPS"
                mobileApp -> this "Hace llamadas API a" "JSON/HTTPS"
                        }
            
            databaseUsers = container "Base de datos de usuarios" "Almacena información de registro de usuarios, registros de acceso, etc" "MySQL ""DataU"{
                apiApp -> this "Lee y escribe en" "SQL"
            }
            
            databaseIncidents = container "Base de datos de incidentes" "Almacena información de registro de emergencias" "MySQL" "DataP"{
                apiApp -> this "Lee y escribe en" "SQL"
            }
        }
        
        gmail = softwareSystem "Gmail" "Sistema interno de google para correos"{
            softwareSystem -> this "Obtiene información de acceso de los usuarios"
            apiApp -> this "Obtiene información de acceso de los usuarios"
        }
        weather = softwareSystem "The Weather Channel" "Pronósticos del clima local"{
            softwareSystem -> this "Permite detectar condiciones climáticas adversas que podrían desencadenar una emergencia"
            apiApp -> this "Permite detectar condiciones climáticas adversas que podrían desencadenar una emergencia"
        }
        maps = softwareSystem "Google Maps" "Servicio de mapas online de Google para información de planes de evacuación e instituciones comunitarias cercanas"{
            apiApp -> this "Permite a los usuarios obtener información sobre zonas de evacuación, etc"
        }
    }

views {
        systemContext softwareSystem {
            include *
            autolayout tb
        }
        container softwareSystem {
            include *
            autolayout tb
        }
        component apiApp {
            include *  
           autolayout tb
        }
        component webApp {
            include *  
           autolayout tb
        }
        
        styles {
            element "DataU"{
                shape "Cylinder" 
                background "#ec0e0e" 
                color "#ffffff"
            }
            element "DataP"{
                shape "Cylinder" 
                background "#ec0e0e" 
                color "#ffffff"
            }
            element "MovilA"{
                shape "MobileDeviceLandscape" 
                background "#438DD5" 
                color "#ffffff"
            }
        }
        theme default
    }
}