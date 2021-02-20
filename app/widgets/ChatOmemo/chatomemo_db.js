var ChatOmemoDB = {
    dbName: 'movim',
    storeName: 'decryptedMessages',
    version: 3,

    db: null,

    setup: async function() {
        var db = window.indexedDB.open(this.dbName, this.version);
        db.onupgradeneeded = function (event) {
            var db = event.target.result;
            db.createObjectStore(ChatOmemoDB.storeName, { keyPath: "id" });
        }

        return db;
    },

    putMessage: async function(id, body) {
        var db = window.indexedDB.open(this.dbName, this.version);

        let promise = new Promise(function(resolve, reject) {
            db.onsuccess = function() {
                var tx = db.result.transaction(ChatOmemoDB.storeName, 'readwrite');
                var os = tx.objectStore(ChatOmemoDB.storeName);

                var request = os.put({"id" : id, "body" : body});
                request.onsuccess = function(event) {
                    resolve(body);
                }
            }
        });

        return promise;
    },

    getMessage: async function(id) {
        var db = window.indexedDB.open(this.dbName, this.version);

        let promise = new Promise(function(resolve, reject) {
            db.onsuccess = function() {
                var tx = db.result.transaction(ChatOmemoDB.storeName, 'readonly');
                var os = tx.objectStore(ChatOmemoDB.storeName);

                var request = os.get(id);
                request.onsuccess = function(event) {
                    if (event.target.result) {
                        resolve(event.target.result.body);
                    } else {
                        resolve();
                    }
                }
            }
        });

        return promise;
    }
}

ChatOmemoDB.setup();