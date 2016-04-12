#Picknick-kartans API

För att komma igång

Ladda ner repot & kör sedan följande kommandon i terminalen:
* bundle install
* rake db:setup

### Användare för testning av api-nyckelgenerering samt api-anrop:
Du loggar in med alla typer av användare från samma formulär på startsidan

- Admin: admin@test.se  lösen "hejhej" (endast för nyckelgenerering)
- Användare: dev@test.se lösen "hejhej"

Fler användare finns i seedsfilen där man även kan se en api-nyckel som alltid genereras och sedan används i postman

###Postman
Det finns en postman-fil här: 

###Dokumentation API
För att kunna använda api:et måste du vara autentisierad för att kunna lägga till, uppdatera eller ta bort de resurser du själv äger. Jag föreslår
att du börjar med att köra "Authenticate your self" från postman-filen. Då får du en JWT-web token tillbaka. 
Den används sedan i form av en Authorization headers när du ska göra något av ovan nämnda.

Man måste även skicka med en api-nyckel på varje anrop genom att skriva in den i slutet på varje anrop tex:

.../places?api_key=4THfq1zw8fYklpaqZW4MKA

I övrigt finns det exempel för alla möjliga slags anrop i postman-filen så lek gärna med api:et med utgångspunkt från den. 