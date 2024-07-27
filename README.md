# README

Welcome to AnbyNotes 🎉🎉🎉
This app is built using Rails 7 and is basically a ChatGpt wrapper:
Users can create Notes where they can:
1. Login or Sign up
2. Enter a query, sentence or short paragraph
3. Receive feedback or content from the AI chatbox based on their query
4. Edit and style the content generted by the AI
Basic user authentication is available in this app. Visitors must have a valid account to use the app's service.
If visitors were to try to paste the link to the feature i.e.: /posts/new, they will be immediately redirected to the Log in page
Additionaly, any visitors who make use of the app's features without a valid account/token will be redirected to a warning page
![image](https://github.com/user-attachments/assets/10212497-20f5-4332-ac41-108c5036f58a)

The list of gems used in this app:
1. simple-form: Template forms used to receive user input/query
2. bulma-rails: This app uses the bulma css framework
3. actiontext : Provide a rich-text editor so that users can style their notes
4. devise     : Manages user authentication
5. ruby-openai: The OpenAI API used to power the copywriting feature of this app

Environmental variable and credentials:
The app has 2 important credentials:
1. secret_key_base
2. OpenAI API Key
Sensitive credentials are managed using Rails' built in credentials manager.
Both keys are saved in the encrypted credentials.yml file, to encrypt the file a separate key is saved in the master.key file which is not checked into this version control system for security purposes.

