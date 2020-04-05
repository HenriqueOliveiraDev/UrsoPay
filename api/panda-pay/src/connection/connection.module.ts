import { Module } from '@nestjs/common';
import { databaseProviders } from './connection';

@Module({
    providers:[...databaseProviders],
    exports:[...databaseProviders],
})
export class ConnectionModule {}
