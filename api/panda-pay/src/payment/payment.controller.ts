import { Controller, Post, Body, Res, Get, Param } from '@nestjs/common';
import { PaymentService } from './payment.service';
import { PaymentDTO } from 'src/DTO/paymentDTO';
import { Payment } from 'src/entity/payment.entity';
import { Response } from 'express';
import { UserService } from 'src/user/user.service';
import { User } from 'src/entity/user.entity';
import { UserDTO } from 'src/DTO/userDTO';

@Controller('payment')
export class PaymentController {
    constructor(
        private paymentService: PaymentService,
        private userService: UserService,
    ) { }

    @Post()
    async create(@Body() paymentDTO: PaymentDTO, @Res() res: Response) {
        try {
            var req = new Payment();
            var balance;

            req = await this.paymentService.create(paymentDTO);
            console.log(req);

            if (req) {
                res.json({ "message": "create" });
                
                if(req.type != 'add'){
                    balance = Number(paymentDTO.value * -1);

                }else{
                    balance = Number(paymentDTO.value);
                    
                }

                 var user = await this.userService.setBalance(Number(paymentDTO.id_user), balance);

                if(true){
                    console.log('salvo!!');
                }
            } else {
                res.json({ "message": "dont create" });
            }
        }
        catch (e) {
            console.log(e);
        }
    }

    @Get(':id_user')
    async allPayment(@Param('id_user') id_user, @Res() res: Response) {
        try {
            var payment = Array<Payment>();
            payment = await this.paymentService.allPayment(id_user);

            if (payment.length > 0) {
                res.json({"message" : payment.slice(0).reverse()});
            } else {
                res.json({ "message": "dont user" });
            }
        } catch (e) {
        }
    }

    @Get('/get_balance/:id_user')
    async getBalance(@Param('id_user') id_user: number, @Res() res: Response) {
        try {
            var payment = Array<Payment>();
            payment = await this.paymentService.allPayment(id_user);

            if (payment.length > 0) {
                res.json(payment.slice(0).reverse());
            } else {
                res.json({ "message": "dont user" });
            }
        } catch (e) {
            console.log(e);
        }
    }

}
