package db;

import com.mongodb.client.*;
import com.mongodb.client.model.Filters;
import org.bson.Document;

public class MongoDBUtil {
    private static final String URI = "mongodb://localhost:27017";
    private static final String DB_NAME = "chatApp";
    private static final String USER_COLLECTION = "users";

    public static MongoCollection<Document> getUserCollection() {
        MongoClient mongoClient = MongoClients.create(URI);
        MongoDatabase database = mongoClient.getDatabase(DB_NAME);
        return database.getCollection(USER_COLLECTION);
    }

    public static boolean registerUser(String username, String hashedPassword) {
        if (getPasswordHash(username) != null) return false;
        Document user = new Document("username", username).append("password", hashedPassword);
        getUserCollection().insertOne(user);
        return true;
    }

    public static String getPasswordHash(String username) {
        Document user = getUserCollection().find(Filters.eq("username", username)).first();
        return user != null ? user.getString("password") : null;
    }
}