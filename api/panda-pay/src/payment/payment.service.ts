import { Injectable, Inject } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Payment } from 'src/entity/payment.entity';
import { PaymentDTO } from 'src/DTO/paymentDTO';

@Injectable()
export class PaymentService {
    constructor(
        @Inject('PAYMENT_REPOSITORY')
        private paymentRepository: Repository<Payment>,
    ) { }

    async create(paymentDTO: PaymentDTO): Promise<Payment> {
        var payment = new Payment();

        payment.type = paymentDTO.type;
        payment.value = paymentDTO.value;
        payment.id_user = paymentDTO.id_user;

        return await this.paymentRepository.save(payment);
    }
    async allPayment(id_user: number): Promise<Array<Payment>> {
        return await this.paymentRepository.find({ id_user: id_user});
    }

    async getBalence(id_user: number): Promise<Payment>{
        return await this.paymentRepository.findOne({id_user:id_user});
    }


}
