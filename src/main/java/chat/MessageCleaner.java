
package chat;

import com.mongodb.client.*;
import org.bson.Document;
import static com.mongodb.client.model.Filters.*;
import java.util.Timer;
import java.util.TimerTask;

public class MessageCleaner {
    private static final String URI = "mongodb://localhost:27017";
    private static final String DB_NAME = "chatApp";
    private static final String COLL_NAME = "messages";

    public static void startScheduler() {
        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                try (MongoClient client = MongoClients.create(URI)) {
                    MongoCollection<Document> messages = client.getDatabase(DB_NAME).getCollection(COLL_NAME);
                    long cutoff = System.currentTimeMillis() - (24 * 60 * 60 * 1000);
                    messages.deleteMany(lt("timestamp", cutoff));
                }
            }
        }, 0, 60 * 60 * 1000); // every hour
    }
}
