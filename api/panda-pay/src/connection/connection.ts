import { createConnection } from 'typeorm';

export const databaseProviders = [
    {
    provide: 'DATABASE_CONNECTION',
    useFactory: async () => await createConnection({
        type: 'mysql',
        host: 'testes-dashboard.chdcu4zqgumj.us-east-2.rds.amazonaws.com',
        port: 3306,
        username: 'admin',
        password: 'SitySenhaMySQL',
        database: 'teste',
        entities: [
            __dirname + '/../**/*.entity{.ts,.js}',
        ],

    }),
}
];