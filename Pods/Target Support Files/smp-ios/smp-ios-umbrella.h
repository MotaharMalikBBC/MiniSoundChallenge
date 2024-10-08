#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SMP.h"
#import "BBCSMPBrandable.h"
#import "BBCSMPAccessibilityAnnouncer.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPAirplayObserver.h"
#import "BBCSMPArtworkFetcher.h"
#import "BBCSMPArtworkURLProvider.h"
#import "BBCSMPAVType.h"
#import "BBCSMPBackingOffMediaSelectorPlayerItemProvider.h"
#import "BBCSMPBitrate.h"
#import "BBCSMPBrand.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPButtonPosition.h"
#import "BBCSMPColorFunctions.h"
#import "BBCSMPConnectionPreference.h"
#import "BBCSMPControllable.h"
#import "BBCSMPDecoder.h"
#import "BBCSMPDecoderCurrentPosition.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPDecoderFactory.h"
#import "BBCSMPDefines.h"
#import "BBCSMPDuration.h"
#import "BBCSMPError.h"
#import "BBCSMPErrorObserver.h"
#import "BBCSMPExternalPlaybackAdapter.h"
#import "BBCSMPIcon.h"
#import "BBCSMPImageChefArtworkFetcher.h"
#import "BBCSMPImageChefArtworkURLProvider.h"
#import "BBCSMPInterruptionEndedBehaviour.h"
#import "BBCSMPItem.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItemProvider.h"
#import "BBCSMPLocalPlayerItemProviderBuilder.h"
#import "BBCSMPLoggingDecoderProxyFactory.h"
#import "BBCSMPLogWriter.h"
#import "BBCSMPMediaBitrate.h"
#import "BBCSMPMediaRetrievalType.h"
#import "BBCSMPMediaSelectorConnectionResolver.h"
#import "BBCSMPMediaSelectorItem.h"
#import "BBCSMPNetworkArtworkFetcher.h"
#import "BBCSMPNetworkStatus.h"
#import "BBCSMPNetworkStatusObserver.h"
#import "BBCSMPObserver.h"
#import "BBCSMPOverlayPosition.h"
#import "BBCSMPPictureInPictureAdapter.h"
#import "BBCSMPPictureInPictureAvailabilityObserver.h"
#import "BBCSMPPictureInPictureObserver.h"
#import "BBCSMPPIPSType.h"
#import "BBCSMPPlayerBitrateObserver.h"
#import "BBCSMPPlayerObservable.h"
#import "BBCSMPPlayerSizeObserver.h"
#import "BBCSMPPlayerState.h"
#import "BBCSMPPlayerViewFullscreenPresenter.h"
#import "BBCSMPPlugin.h"
#import "BBCSMPPluginEnvironment.h"
#import "BBCSMPPluginFactory.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemoteCommandCenter.h"
#import "BBCSMPResolvedContent.h"
#import "BBCSMPSettingsPersistence.h"
#import "BBCSMPSize.h"
#import "BBCSMPState.h"
#import "BBCSMPStateObservable.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPStaticURLArtworkURLProvider.h"
#import "BBCSMPStaticURLPlayerItemProvider.h"
#import "BBCSMPStatisticsConsumer.h"
#import "BBCSMPStreamType.h"
#import "BBCSMPSubtitle.h"
#import "BBCSMPSubtitleChunk.h"
#import "BBCSMPSubtitleFetcher.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPSubtitleRegion.h"
#import "BBCSMPSubtitlesUIConfiguration.h"
#import "BBCSMPSuspendRule.h"
#import "BBCSMPTime.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPTouchPassThroughView.h"
#import "BBCSMPUI.h"
#import "BBCSMPUIBuilder.h"
#import "BBCSMPUIComposer.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPUIDefaultConfiguration.h"
#import "BBCSMPUIEmbeddedDefaultConfiguration.h"
#import "BBCSMPUIFullscreenDefaultConfiguration.h"
#import "BBCSMPUniversalLogWriter.h"
#import "BBCSMPUnpreparedStateListener.h"
#import "BBCSMPURLResolvedContent.h"
#import "BBCSMPUserAgentProvider.h"
#import "BBCSMPUserInteractionEvent.h"
#import "BBCSMPUserInteractionObserver.h"
#import "BBCSMPUserInteractionStatisticsConsumer.h"
#import "BBCSMPVersion.h"
#import "BBCSMPVideoSurface.h"
#import "BBCSMPVideoSurfaceContext.h"
#import "BBCSMPVideoSurfaceManager.h"
#import "BBCSMPVolumeObserver.h"
#import "BBCSMPVolumeProvider.h"
#import "MPNowPlayingInfoCenterProtocol.h"
#import "AVPlayerProtocol.h"
#import "BBCSMPBackgroundObserver.h"
#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPInternalStateObserver.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPPictureInPictureController.h"
#import "BBCSMPSettingsPersistenceFilesystem.h"
#import "BBCSMPSubtitleScene.h"
#import "BBCSMPSubtitleView.h"
#import "BBCSMPSuspendMechanism.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "BBCSMPTimerProtocol.h"
#import "BBCSMPAVDecoderFactory.h"
#import "BBCSMPAVFailedToLoadPlaylistEvent.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPNotificationReceptionist.h"
#import "BBCSMPWorker.h"
#import "BBCSMPAVRateChangedEvent.h"
#import "BBCSMPPlayerBuilder.h"
#import "BBCSMPNetworkSubtitleFetcher.h"
#import "BBCSMPSubtitleParser.h"
#import "BBCSMPSubtitleParserResult.h"

FOUNDATION_EXPORT double SMPVersionNumber;
FOUNDATION_EXPORT const unsigned char SMPVersionString[];

