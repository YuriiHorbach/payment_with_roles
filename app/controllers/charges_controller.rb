# frozen_string_literal: true

class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 2500

    customer = Stripe::Customer.create(
      email: 'customer@gmail.com',
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Carier\'s Customer',
      currency: 'usd'
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
