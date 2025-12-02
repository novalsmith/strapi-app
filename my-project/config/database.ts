import path from 'path';

export default ({ env }) => {
  const isProduction = env('NODE_ENV') === 'production';

  const DB_HOST = isProduction
    ? env('DATABASE_HOST', env('MYSQL_HOST', 'mysql-db'))
    : env('DATABASE_HOST', '127.0.0.1');

  const DB_PORT = env.int('DATABASE_PORT', 3306);
  const DB_USER = env('DATABASE_USERNAME', env('MYSQL_USER', 'novalstrapiuser'));
  const DB_NAME = env('DATABASE_NAME', env('MYSQL_DATABASE_NAME', 'gkilahairoidb'));
  const DB_PASSWORD = env('DATABASE_PASSWORD',
    isProduction
      ? env('MYSQL_PASSWORD_PROD')
      : env('MYSQL_PASSWORD_DEV')
  );

  const client = 'mysql';

  const connections = {
    mysql: {
      connection: {
        host: DB_HOST,
        port: DB_PORT,
        database: DB_NAME,
        user: DB_USER,
        password: DB_PASSWORD,
        ssl: env.bool('DATABASE_SSL', false) && {
          key: env('DATABASE_SSL_KEY', undefined),
          cert: env('DATABASE_SSL_CERT', undefined),
          ca: env('DATABASE_SSL_CA', undefined),
          capath: env('DATABASE_SSL_CAPATH', undefined),
          cipher: env('DATABASE_SSL_CIPHER', undefined),
          rejectUnauthorized: env.bool('DATABASE_SSL_REJECT_UNAUTHORIZED', true),
        },
      },
      pool: { min: env.int('DATABASE_POOL_MIN', 2), max: env.int('DATABASE_POOL_MAX', 10) },
    },
    // 💥 HARUS ADA BLOK INI SEBAGAI FALLBACK YANG VALID!
    sqlite: {
      connection: {
        filename: path.join(__dirname, '..', '..', env('DATABASE_FILENAME', '.tmp/data.db')),
      },
      useNullAsDefault: true,
    },
  };

  return {
    connection: {
      client,
      ...connections[client],
      acquireConnectionTimeout: env.int('DATABASE_CONNECTION_TIMEOUT', 60000),
    },
  };
};