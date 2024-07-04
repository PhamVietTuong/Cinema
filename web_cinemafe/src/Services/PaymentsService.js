import { baseService } from "./BaseService";

export class PaymentsService extends baseService {
    CreateLinkCheckoutMomo = (paymentRequest) => {
        return this.post(`api/Payments/CreateLinkCheckoutMomo`, paymentRequest)
    }

    CreateLinkCheckoutVNPAY = (paymentRequest) => {
        return this.post(`api/Payments/VNPayCreatePayment`, paymentRequest)
    }
}

export const paymentsService = new PaymentsService();