import java.sql.*;

void main() {
    try {
        // carregar el driver al controlador
        Class.forName("org.postgresql.Driver");
        IO.println("Driver de PostgreSQL carregat correctament.");

        Properties props = getProperties();

        Connection c = DriverManager.getConnection(String.format("jdbc:postgresql://postgresfib.fib.upc.es:6433/DB%s", props.get("user")), props);
        c.setAutoCommit(false);
        IO.println("Connexio realitzada correctament.");

        // canvi de l'esquema per defecte a un altre esquema
        Statement s = c.createStatement();
        s.executeUpdate("set search_path to public;"); // Seleccionamos el schema public
        s.close();

        IO.println("Canvi d'esquema realitzat correctament.");

        Statement st = c.createStatement();
        ResultSet r = st.executeQuery("SELECT * FROM estacio;");
        while (r.next()) {
            String nomEstacio = r.getString("nom_estacio");
            String superficie = r.getString("superficie");
            String capacitat = r.getString("capacitat");

            IO.println(String.format("[ %s | %s | %s ]", nomEstacio, superficie, capacitat));
        }

        c.commit();
        c.close();
        IO.println("Rollback i desconnexio realitzats correctament.");
    } catch (ClassNotFoundException ce) {
        IO.println("Error al carregar el driver");
    } catch (SQLException se) {
        IO.println("Excepcio: ===========================");
        IO.println("El getSQLState es: " + se.getSQLState());
        IO.println("El getMessage es: " + se.getMessage());
    }
}

private static Properties getProperties() {
    String nom = "nom.fib";
    String password = "DBpassword";

    // connectar a la base de dades
    // cal modificar el username, password i el nom de la base de dades
    // en el servidor postgresfib, SEMPRE el SSL ha de ser true
    Properties props = new Properties();
    props.setProperty("user", nom); // Nombre de usuario
    props.setProperty("password", password);    // Contraseña
    props.setProperty("ssl", "true");
    props.setProperty("sslfactory", "org.postgresql.ssl.NonValidatingFactory");

    return props;
}