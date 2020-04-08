import { Module } from '@nestjs/common';
import { PaymentController } from './payment.controller';
import { ConnectionModule } from 'src/connection/connection.module';
import { paymentProviders } from './payment.provider';

import { PaymentService } from './payment.service';
import { UserService } from 'src/user/user.service';
import { UserModule } from 'src/user/user.module';

@Module({
  imports:[ConnectionModule, UserModule],
  providers:[PaymentService, ...paymentProviders],
  controllers:[PaymentController],    
  exports:[PaymentService],
  
})
export class PaymentModule {}
