import { Connection, Repository } from 'typeorm';
import { Payment } from 'src/entity/payment.entity';

export const paymentProviders = [
  {
    provide: 'PAYMENT_REPOSITORY',
    useFactory: (connection: Connection) => connection.getRepository(Payment),
    inject: ['DATABASE_CONNECTION'],
  },
];