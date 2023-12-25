package com.example.jspnew.javabean;


import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GenericDAO {
    private static final String DB_URL = "jdbc:sqlserver://localhost:3066;databaseName=TestSystem;trustServerCertificate=true";
    private static final String DB_USERNAME = "sa";
    private static final String DB_PASSWORD = "sjk12345";
    private Connection connection;
    public  GenericDAO() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
     connection=DriverManager.getConnection(DB_URL,DB_USERNAME,DB_PASSWORD);

    }//7/3修改,暂时还未使用

    public GenericDAO(Connection connection) {
        this.connection = connection;
    }

    public <T> void insert(T entity) throws SQLException {
        Class<?> clazz = entity.getClass();
        String tableName = clazz.getSimpleName().toLowerCase();

        StringBuilder columnsBuilder = new StringBuilder();
        StringBuilder valuesBuilder = new StringBuilder();

        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            String columnName = field.getName();
            Object value = null;

            try {
                Method getter = clazz.getMethod(getGetterMethodName(field));
                value = getter.invoke(entity);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (value != null) {
                columnsBuilder.append(columnName).append(",");
                valuesBuilder.append("?,");
            }
        }

        String columns = columnsBuilder.deleteCharAt(columnsBuilder.length() - 1).toString();
        String values = valuesBuilder.deleteCharAt(valuesBuilder.length() - 1).toString();

        String query = "INSERT INTO " + tableName + "(" + columns + ") VALUES (" + values + ")";
        PreparedStatement statement = connection.prepareStatement(query);

        int parameterIndex = 1;
        for (Field field : fields) {
            Object value = null;

            try {
                Method getter = clazz.getMethod(getGetterMethodName(field));
                value = getter.invoke(entity);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (value != null) {
                statement.setObject(parameterIndex, value);
                parameterIndex++;
            }
        }

        statement.executeUpdate();
        statement.close();
    }

    public <T> void insertWithAutoIncrement(T entity) throws SQLException {
        Class<?> clazz = entity.getClass();
        String tableName = clazz.getSimpleName().toLowerCase();

        StringBuilder columnsBuilder = new StringBuilder();
        StringBuilder valuesBuilder = new StringBuilder();

        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            String columnName = field.getName();
            Object value = null;

            try {
                Method getter = clazz.getMethod(getGetterMethodName(field));
                value = getter.invoke(entity);
            } catch (Exception e) {
                e.printStackTrace();
            }

            // 排除自增主键的处理
            if (!columnName.equals("question_id")) {
                if (value != null) {
                    columnsBuilder.append(columnName).append(",");
                    valuesBuilder.append("?,");
                }
            }
        }

        String columns = columnsBuilder.deleteCharAt(columnsBuilder.length() - 1).toString();
        String values = valuesBuilder.deleteCharAt(valuesBuilder.length() - 1).toString();

        String query = "INSERT INTO " + tableName + "(" + columns + ") VALUES (" + values + ")";
        PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

        int parameterIndex = 1;
        for (Field field : fields) {
            String columnName = field.getName();
            Object value = null;

            try {
                Method getter = clazz.getMethod(getGetterMethodName(field));
                value = getter.invoke(entity);
            } catch (Exception e) {
                e.printStackTrace();
            }

            // 排除自增主键的处理
            if (!columnName.equals("question_id")) {
                if (value != null) {
                    statement.setObject(parameterIndex, value);
                    parameterIndex++;
                }
            }
        }

        statement.executeUpdate();

        // 获取自增主键的值
        ResultSet generatedKeys = statement.getGeneratedKeys();
        if (generatedKeys.next()) {
            // 将自增主键的值设置到实体对象中
            long generatedKey = generatedKeys.getLong(1);
            try {
                Method setter = clazz.getMethod("setId", long.class); // 假设setId是设置自增主键的方法
                setter.invoke(entity, generatedKey);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        statement.close();
    }



    public <T> void update(T entity) throws SQLException {
        Class<?> clazz = entity.getClass();
        String tableName = clazz.getSimpleName().toLowerCase();

        StringBuilder updateBuilder = new StringBuilder();

        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            String columnName = field.getName();
            Object value = null;

            try {
                Method getter = clazz.getMethod(getGetterMethodName(field));
                value = getter.invoke(entity);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (value != null) {
                updateBuilder.append(columnName).append("=?,");
            }
        }

        String updates = updateBuilder.deleteCharAt(updateBuilder.length() - 1).toString();

        String query = "UPDATE " + tableName + " SET " + updates + " WHERE id=?";
        PreparedStatement statement = connection.prepareStatement(query);

        int parameterIndex = 1;
        for (Field field : fields) {
            Object value = null;

            try {
                Method getter = clazz.getMethod(getGetterMethodName(field));
                value = getter.invoke(entity);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (value != null) {
                statement.setObject(parameterIndex, value);
                parameterIndex++;
            }
        }


        try {
            Method getter = clazz.getMethod("getId");
            Object id = getter.invoke(entity);
            statement.setObject(parameterIndex, id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        statement.executeUpdate();
        statement.close();
    }
    public <T> void delete(T entity) throws SQLException {
        Class<?> clazz = entity.getClass();
        String tableName = clazz.getSimpleName().toLowerCase();

        String query = "DELETE FROM " + tableName + " WHERE id=?";
        PreparedStatement statement = connection.prepareStatement(query);

        try {
            Method getter = clazz.getMethod("getId");
            Object id = getter.invoke(entity);
            statement.setObject(1, id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        statement.executeUpdate();
        statement.close();
    }


    public <T> List<T> getAll(Class<T> clazz) throws SQLException {
        List<T> entities = new ArrayList<>();

        String tableName = clazz.getSimpleName().toLowerCase();
        String query = " SELECT * FROM " + tableName;
        PreparedStatement statement = connection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            T entity = createEntityFromResultSet(clazz, resultSet);
            entities.add(entity);
        }

        resultSet.close();
        statement.close();

        return entities;
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    public <T> T getById(Class<T> clazz, int id) throws SQLException {
        String tableName = clazz.getSimpleName().toLowerCase();
        String query = "SELECT * FROM " + tableName + " WHERE id=?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        T entity = null;
        if (resultSet.next()) {
            entity = createEntityFromResultSet(clazz, resultSet);
        }

        resultSet.close();
        statement.close();

        return entity;
    }
    public <T> T getById(Class<T> clazz, String id) throws SQLException {
        String tableName = clazz.getSimpleName().toLowerCase();
        String query = "SELECT * FROM " + tableName + " WHERE paper_id=?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, id);
        ResultSet resultSet = statement.executeQuery();

        T entity = null;
        if (resultSet.next()) {
            entity = createEntityFromResultSet(clazz, resultSet);
        }

        resultSet.close();
        statement.close();

        return entity;
    }

    private <T> T createEntityFromResultSet(Class<T> clazz, ResultSet resultSet) throws SQLException {
        T entity = null;

        try {
            entity = clazz.getDeclaredConstructor().newInstance();

            Field[] fields = clazz.getDeclaredFields();
            for (Field field : fields) {
                String columnName = field.getName();
                Object value = resultSet.getObject(columnName);

                Method setter = clazz.getMethod(getSetterMethodName(field), field.getType());
                setter.invoke(entity, value);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return entity;
    }

    private String getGetterMethodName(Field field) {
        String fieldName = field.getName();
        return "get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
    }

    private String getSetterMethodName(Field field) {
        String fieldName = field.getName();
        return "set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
    }
}
