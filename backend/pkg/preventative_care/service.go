package preventative_care

// Service Step 1 define the interface
type Service interface {
	GetRecommendedCareItems(req RecommendedPreventativeCareItemRequest) (RecommendedPreventativeCareItemResponse, error)
}

// Step 2 Define the struct that can be used elsewhere in the application. This doesn't
// Instantiate it - it's just a definition.
type preventativeCareService struct {
	repository Repository
}

// NewService Use this function to actually instantiate the service somewhere in the application
func NewService(repository Repository) Service {
	return &preventativeCareService{repository: repository}
}

// GetRecommendedCareItems Implement the interface
func (s *preventativeCareService) GetRecommendedCareItems(req RecommendedPreventativeCareItemRequest) (RecommendedPreventativeCareItemResponse, error) {
	r := RecommendedPreventativeCareItemResponse{}

	items, err := s.repository.GetPreventativeCareItems(req)

	if err != nil {
		return r, err
	}

	r.RecommendedPreventativeCareItems = items

	return r, nil

}
