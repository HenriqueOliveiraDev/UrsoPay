import { Injectable, Inject } from '@nestjs/common';
import { User } from 'src/entity/user.entity';
import { Repository } from 'typeorm';
import { UserDTO } from 'src/DTO/userDTO';
import { PaymentDTO } from 'src/DTO/paymentDTO';

@Injectable()
export class UserService {
    constructor(
        @Inject('USER_REPOSITORY')
        private userRepository: Repository<User>,
    ) { }
    printOn(): string {
        return 'User on';
    }

    async create(userDTO: UserDTO): Promise<User> {
        const user = new User();

        user.name = userDTO.name;
        user.email = userDTO.email;
        user.cpf = userDTO.cpf;
        user.password = userDTO.password;
        user.phone = userDTO.phone;

        return await this.userRepository.save(user);
    }

    async allUsers(): Promise<Array<User>> {
        return await this.userRepository.find();
    }

    async getUser(id: number): Promise<User> {
        return await this.userRepository.findOne(id);
    }
    async isUser(phone: string): Promise<User> {
        return await this.userRepository.findOne({ cpf: phone });
    }

    async login(cpf: string, password: string): Promise<User> {
        return await this.userRepository.findOne({ cpf: cpf, password: password });
    }

    async setBalance(id_user: number, balance: number) {
        var user = new User();
        user = await this.userRepository.findOne(id_user);
        var n1 = Number(user.balance);
        var resul = n1+balance;
        user.balance = resul;
        console.log(resul);

        return await this.userRepository.save(user);
    }

    async getBalance(id_user: number): Promise<User>{
        return await this.userRepository.findOne(id_user);
    }
}

