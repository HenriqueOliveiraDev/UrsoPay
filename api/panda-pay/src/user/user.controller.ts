import { Controller, Get, Post, Body, Res, Param } from '@nestjs/common';
import { UserService } from './user.service';
import { UserDTO } from 'src/DTO/userDTO';
import { Response } from 'express';
import { User } from 'src/entity/user.entity';
@Controller('user')
export class UserController {
    constructor(
        private userService: UserService
    ){}

    @Post('signup')
    create(@Body() user, @Res() res: Response) {
        try{
            this.userService.create(user);
            res.status(200).json({"message" : "Create"})
        }
        catch(e){
            console.log(e);
        }
    }

    @Get()
    async allUser(@Res() res: Response){
        let user = new Array<User>();
        user = await this.userService.allUsers();   
        if(user){
            res.status(200).json(user);
        }

    }

    @Get(':id')
    async getUser(@Param('id') id, @Res() res: Response){
        let user = new User();
        user = await this.userService.getUser(id);   
        if(user){
            res.status(200).json(user);
        }
        
    }


}
