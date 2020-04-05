import { Injectable, Inject } from '@nestjs/common';
import { User } from 'src/entity/user.entity';
import { Repository } from 'typeorm';
import { UserDTO } from 'src/DTO/userDTO';

@Injectable()
export class UserService {
    constructor(
        @Inject('USER_REPOSITORY')
        private userRepository: Repository<User>,
    ) { }
    printOn(): string {
        return 'User on';
    }

    async create(userDTO: UserDTO){
        const user = new User();

        user.name = userDTO.name;
        user.email = userDTO.email;
        user.cpf = userDTO.cpf;
        user.password = userDTO.password;
        user.phone = userDTO.phone;

        await this.userRepository.save(user);
    }

    async allUsers(): Promise<Array<User>>{
        return await this.userRepository.find();
    }

    async getUser(id: number): Promise<User>{
        return await this.userRepository.findOne(id);
    }
}

