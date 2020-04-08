import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity()
export class Payment{
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    type: string;

    @Column()
    value: number;

    @Column()
    id_user: number;

}