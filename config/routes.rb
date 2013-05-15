JuniorDevInvoicingExam::Application.routes.draw do
  resources :reports do
    collection do
      get 'all_invoices'
      get 'deadbeats'
      get 'revenue_per_month'
    end
  end

  root :to => "reports#index"
end
