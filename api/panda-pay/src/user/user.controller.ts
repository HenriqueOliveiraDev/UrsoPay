import { Controller, Get, Post, Body, Res, Param } from '@nestjs/common';
import { UserService } from './user.service';
import { UserDTO } from 'src/DTO/userDTO';
import { Response } from 'express';
import { User } from 'src/entity/user.entity';
@Controller('user')
export class UserController {
    constructor(
        private userService: UserService
    ) { }

    @Post('signup')
    async create(@Body() user, @Res() res: Response) {
        try {
            var req = new User();
            req = await this.userService.create(user);
            if (req) {
                res.json(req);
            } else {
                res.json({ "message": "dont create" });
            }

        }
        catch (e) {
            console.log(e);
        }
    }

    @Get()
    async allUser(@Res() res: Response) {
        let user = new Array<User>();
        user = await this.userService.allUsers();
        if (user) {
            res.status(200).json(user);
        }

    }

    @Get(':id')
    async getUser(@Param('id') id, @Res() res: Response) {
        let user = new User();
        user = await this.userService.getUser(id);
        if (user) {
            res.status(200).json(user);
        }

    }

    @Get('user_cpf/:cpf')
    async isUser(@Param('cpf') phone, @Res() res: Response) {
        let user = new User();
        user = await this.userService.isUser(phone);
        if (user) {
            res.json({ "message": true });
        } else {
            res.json({ "message": false });
        }
    }

    @Post('login')
    async login(@Body() userDTO: UserDTO, @Res() res: Response) {
        let user = new User();
        user = await this.userService.login(userDTO.cpf, userDTO.password);

        if (user) {
            res.json(user);
        } else {
            res.json({ "message": "login invalid" });
        }
    }

    @Get('get_balance/:id')
    async getBalance(@Param('id') id: number, @Res() res: Response) {
        var user = new User();
        try {
            user = await this.userService.getBalance(id);

            if (user) {
                res.json({ "balance": user.balance })
            }
        }
        catch (e) {
            console.log(e);
        }

    }

}
