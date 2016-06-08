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
Det finns en postman-fil här: [https://github.com/fh222dt/fh222dt_ror/blob/master/PicknickAPI.json.postman_collection](https://github.com/fh222dt/fh222dt_ror/blob/master/PicknickAPI.json.postman_collection)

###Dokumentation API
För att kunna använda api:et måste du vara autentisierad för att kunna lägga till, uppdatera eller ta bort de resurser du själv äger. Jag föreslår
att du börjar med att köra "Authenticate your self" från postman-filen. Då får du en JWT-web token tillbaka. 
Den används sedan i form av en Authorization headers när du ska göra något av ovan nämnda.

Man måste även skicka med en api-nyckel på varje anrop genom att skriva in den i slutet på varje anrop tex:

.../places?api_key=4THfq1zw8fYklpaqZW4MKA

I övrigt finns det exempel för alla möjliga slags anrop i postman-filen så lek gärna med api:et med utgångspunkt från den. 


###Förändringar inför clientappen
Jag har gjort om mina routes så att de som hör till APIet bara svarar med json. Innan jag gjorde detta fick jag 408-fel. 

Sen har jag använt gemet cors som blev rekommenderat. Enkelt att använda. Fick trixa lite med vilka format som ska godkännas bara.

Jag har också ändrat så att mina svar kommer som ett json objekt istället för en array. Jag har också lagt till så det går att söka på 
beskrivningar till platserna, det hade jag råkat glömma från förra gången.