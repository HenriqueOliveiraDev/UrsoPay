import { Module } from '@nestjs/common';
import { ConnectionModule } from 'src/connection/connection.module';
import { userProviders } from './user.provider';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { PaymentController } from 'src/payment/payment.controller';

@Module({
    imports:[ConnectionModule],
    providers:[UserService, ...userProviders],
    controllers:[UserController],    
    exports:[UserService],
    
})
export class UserModule {
    
}
