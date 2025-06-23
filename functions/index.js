const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const { GraphQLClient } = require("graphql-request");


const client = new GraphQLClient("https://trusted-eft-22.hasura.app/v1/graphql", {
  headers: {
    "content-type": "application/json",
    "x-hasura-admin-secret": "w7oQ6tEr062bFK5OZEPi2fIjOxQ4fdfDwB1hCXmxL0LFqAgYnvpOkcFCjT0WViyr",
  },
});


admin.initializeApp(functions.config().firebase);

// Função para registrar usuário e setar custom claims
exports.registerUser = functions.https.onCall(async (data, context) => {

    const email = data.email;
    const password = data.password;
    const displayName = data.displayName;

    if (email == null || password == null || displayName == null) {
        throw new functions.https.HttpsError('signup-failed', 'missing information');
    }

    try {
        var userRecord = await admin.auth().createUser({
            email: email,
            password: password,
            displayName: displayName
        });

        const customClaims = {
            "https://hasura.io/jwt/claims": {
                "x-hasura-default-role": "user",
                "x-hasura-allowed-roles": ["user"],
                "x-hasura-user-id": userRecord.uid
            }
        };

        await admin.auth().setCustomUserClaims(userRecord.uid, customClaims);
        return userRecord.toJSON();

    } catch (e) {
        throw new functions.https.HttpsError('signup-failed', JSON.stringify(error, undefined, 2));
    }
});

// Trigger para inserir usuário no Hasura ao criar no Firebase Auth
exports.processSignUp = functions.auth.user().onCreate(async user => {

    const id = user.uid;
    const email = user.email;
    const name = user.displayName || "No Name";

    const mutation = `mutation($id: String!, $email: String, $name: String) {
    insert_user(objects: [{
        id: $id,
        email: $email,
        name: $name,
      }]) {
        affected_rows
      }
    }`;
    try {
        const data = await client.request(mutation, {
            id: id,
            email: email,
            name: name
        })

        return data;
    } catch (e) {
        throw new functions.https.HttpsError('sync-failed');
    }
});
// Trigger para deletar usuário no Hasura ao deletar no Firebase Auth
exports.processDelete = functions.auth.user().onDelete(async (user) => {
    const mutation = `mutation($id: String!) {
        delete_user(where: {id: {_eq: $id}}) {
          affected_rows
        }
    }`;
    const id = user.uid;
    try {
        const data = await client.request(mutation, {
            id: id,
        })
        return data;
    } catch (e) {
        throw new functions.https.HttpsError('sync-failed');

    }
});