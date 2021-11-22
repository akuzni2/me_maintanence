package preventative_care

type RecommendedPreventativeCareItem struct {
	Id             int    `json:"id"`
	SearchTerm     string `json:"searchTerm"`
	Title          string `json:"title"`
	Description    string `json:"description"`
	Gender         string `json:"gender"`
	AgeRangeMin    int    `json:"ageRangeMin"`
	AgeRangeMax    int    `json:"ageRangeMax"`
	SmokingHistory bool   `json:"smokingHistory"`
	Recurring      bool   `json:"isRecurring"`
	AnnualInterval int    `json:"annualInterval"`
}

type RecommendedPreventativeCareItemRequest struct {
	Age    int
	Gender string
}

type RecommendedPreventativeCareItemResponse struct {
	RecommendedPreventativeCareItems []RecommendedPreventativeCareItem `json:"items,omitempty"`
}
