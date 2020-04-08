import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConnectionModule } from './connection/connection.module';
import { UserService } from './user/user.service';
import { UserController } from './user/user.controller';
import { UserModule } from './user/user.module';
import { userProviders } from './user/user.provider';
import { PaymentService } from './payment/payment.service';
import { PaymentModule } from './payment/payment.module';
import { PaymentController } from './payment/payment.controller';

@Module({
  imports: [ConnectionModule, UserModule, PaymentModule],
  controllers: [AppController, UserController, PaymentController],
  providers: [AppService],
})
export class AppModule {}
