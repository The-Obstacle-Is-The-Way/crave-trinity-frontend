//
//  DependencyContainer.swift
//  CravePhone
//
//  Uncle Bob & Steve Jobs Style:
//   - Fixes incorrect argument labels and type mismatches.
//   - Passes 'manager:' instead of 'cravingManager:' to CravingRepositoryImpl.
//   - Passes 'cravingRepository' (not an addCravingUseCase) to LogCravingViewModel initializer.
//

import SwiftUI
import SwiftData

@MainActor
public final class DependencyContainer: ObservableObject {
    
    @Published private(set) var modelContainer: ModelContainer
    
    // MARK: - Craving (Phone) Dependencies
    private lazy var cravingManager: CravingManager = {
        // Pass 'modelContext' directly
        CravingManager(modelContext: modelContainer.mainContext)
    }()
    
    private lazy var cravingRepository: CravingRepository = {
        // Use 'manager:' instead of 'cravingManager:' to match init signature
        CravingRepositoryImpl(manager: cravingManager)
    }()
    
    // MARK: - Analytics + AI Chat (unchanged except for local references)
    private lazy var analyticsStorage: AnalyticsStorageProtocol = {
        LocalAnalyticsStorage() // or your real implementation
    }()
    private lazy var analyticsMapper: AnalyticsMapper = {
        AnalyticsMapper()
    }()
    private lazy var analyticsRepository: AnalyticsRepositoryProtocol = {
        AnalyticsRepositoryImpl(storage: analyticsStorage, mapper: analyticsMapper)
    }()
    private lazy var analyticsAggregator: AnalyticsAggregatorProtocol = {
        AnalyticsAggregatorImpl(storage: analyticsStorage)
    }()
    private lazy var analyticsConfig: AnalyticsConfiguration = {
        AnalyticsConfiguration.shared
    }()
    private lazy var patternDetectionService: PatternDetectionServiceProtocol = {
        PatternDetectionServiceImpl(
            storage: analyticsStorage,
            configuration: analyticsConfig
        )
    }()
    private lazy var analyticsManager: AnalyticsManager = {
        AnalyticsManager(
            repository: analyticsRepository,
            aggregator: analyticsAggregator,
            patternDetection: patternDetectionService
        )
    }()
    
    private lazy var apiClient: APIClient = {
        APIClient()
    }()
    private lazy var baseURL: URL = {
        URL(string: "https://your-crave-backend.com")!
    }()
    private lazy var aiChatRepository: AiChatRepositoryProtocol = {
        AiChatRepositoryImpl(apiClient: apiClient, baseURL: baseURL)
    }()
    private lazy var aiChatUseCase: AiChatUseCaseProtocol = {
        AiChatUseCase(repository: aiChatRepository)
    }()
    
    // MARK: - SwiftData Initialization
    public init() {
        // Create model container for SwiftData
        let schema = Schema([CravingEntity.self, AnalyticsMetadata.self])
        do {
            self.modelContainer = try ModelContainer(for: schema)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    // MARK: - Optional Use Cases (If needed)
    private func makeAddCravingUseCase() -> AddCravingUseCaseProtocol {
        AddCravingUseCase(cravingRepository: cravingRepository)
    }
    private func makeFetchCravingsUseCase() -> FetchCravingsUseCaseProtocol {
        FetchCravingsUseCase(cravingRepository: cravingRepository)
    }
    private func makeArchiveCravingUseCase() -> ArchiveCravingUseCaseProtocol {
        ArchiveCravingUseCase(cravingRepository: cravingRepository)
    }
    
    // MARK: - Public Factories
    public func makeLogCravingViewModel() -> LogCravingViewModel {
        // Pass the repository directly to match the VM init signature
        LogCravingViewModel(cravingRepository: cravingRepository)
    }
    
    public func makeCravingListViewModel() -> CravingListViewModel {
        CravingListViewModel(
            fetchCravingsUseCase: makeFetchCravingsUseCase(),
            archiveCravingUseCase: makeArchiveCravingUseCase()
        )
    }
    
    public func makeAnalyticsViewModel() -> AnalyticsViewModel {
        AnalyticsViewModel(manager: analyticsManager)
    }
    
    public func makeChatViewModel() -> ChatViewModel {
        ChatViewModel(aiChatUseCase: aiChatUseCase)
    }
}


// MARK: - Sample LocalAnalyticsStorage (Placeholder)
private final class LocalAnalyticsStorage: AnalyticsStorageProtocol {
    func store(_ event: AnalyticsDTO) async throws {}
    func fetchEvents(from startDate: Date, to endDate: Date) async throws -> [AnalyticsDTO] { [] }
    func fetchEvents(ofType eventType: String) async throws -> [AnalyticsDTO] { [] }
    func fetchMetadata(forCravingId cravingId: UUID) async throws -> AnalyticsMetadata? { nil }
    func update(metadata: AnalyticsMetadata) async throws {}
    func storeBatch(_ events: [AnalyticsDTO]) async throws {}
    func cleanupData(before date: Date) async throws {}
}

