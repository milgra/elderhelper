(defproject elderhelper "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.10.0"]
                 [compojure "1.6.1"]
                 [ring/ring-defaults "0.3.2"]
                 [ring/ring-core "1.8.1"]
                 [ring/ring-json "0.5.0"]
                 [mysql/mysql-connector-java "8.0.20"]
                 [migratus "1.2.8"]
                 [korma "0.4.3"]                 
                 [hiccup "1.0.5"]
                 [buddy/buddy-auth "2.2.0"]]

  :plugins [[lein-ring "0.12.5"]
            [migratus-lein "0.7.3"]]

  :migratus {:store :database
             :migration-dir "migrations"
             :db (clojure.edn/read-string (slurp "database/migratus-conf.edn"))}

  :ring {:handler elderhelper.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring/ring-mock "0.3.2"]]}})
