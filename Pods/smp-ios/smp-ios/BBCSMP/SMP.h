//
//  SMP.h
//  SMP
//
//  Created by an Xcode Script Phase
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for SMP.
FOUNDATION_EXPORT double SMPVersionNumber;

//! Project version string for SMP.
FOUNDATION_EXPORT const unsigned char SMPVersionString[];

#import <SMP/AVPlayerProtocol.h>
#import <SMP/BBCSMPAVDecoderFactory.h>
#import <SMP/BBCSMPAVType.h>
#import <SMP/BBCSMPAccessibilityAnnouncer.h>
#import <SMP/BBCSMPAccessibilityIndex.h>
#import <SMP/BBCSMPAirplayObserver.h>
#import <SMP/BBCSMPArtworkFetcher.h>
#import <SMP/BBCSMPArtworkURLProvider.h>
#import <SMP/BBCSMPBackgroundObserver.h>
#import <SMP/BBCSMPBackgroundStateProvider.h>
#import <SMP/BBCSMPBackingOffMediaSelectorPlayerItemProvider.h>
#import <SMP/BBCSMPBitrate.h>
#import <SMP/BBCSMPBrand.h>
#import <SMP/BBCSMPBrandingIcons.h>
#import <SMP/BBCSMPButtonPosition.h>
#import <SMP/BBCSMPColorFunctions.h>
#import <SMP/BBCSMPConnectionPreference.h>
#import <SMP/BBCSMPControllable.h>
#import <SMP/BBCSMPDecoder.h>
#import <SMP/BBCSMPDecoderCurrentPosition.h>
#import <SMP/BBCSMPDecoderDelegate.h>
#import <SMP/BBCSMPDecoderFactory.h>
#import <SMP/BBCSMPDefines.h>
#import <SMP/BBCSMPDuration.h>
#import <SMP/BBCSMPError.h>
#import <SMP/BBCSMPErrorObserver.h>
#import <SMP/BBCSMPEventBus.h>
#import <SMP/BBCSMPExternalPlaybackAdapter.h>
#import <SMP/BBCSMPIcon.h>
#import <SMP/BBCSMPImageChefArtworkFetcher.h>
#import <SMP/BBCSMPImageChefArtworkURLProvider.h>
#import <SMP/BBCSMPInternalStateObserver.h>
#import <SMP/BBCSMPInterruptionEndedBehaviour.h>
#import <SMP/BBCSMPItem.h>
#import <SMP/BBCSMPItemMetadata.h>
#import <SMP/BBCSMPItemObserver.h>
#import <SMP/BBCSMPItemPreloadMetadata.h>
#import <SMP/BBCSMPItemProvider.h>
#import <SMP/BBCSMPLocalPlayerItemProviderBuilder.h>
#import <SMP/BBCSMPLogWriter.h>
#import <SMP/BBCSMPLoggingDecoderProxyFactory.h>
#import <SMP/BBCSMPMediaBitrate.h>
#import <SMP/BBCSMPMediaRetrievalType.h>
#import <SMP/BBCSMPMediaSelectorConnectionResolver.h>
#import <SMP/BBCSMPMediaSelectorItem.h>
#import <SMP/BBCSMPNetworkArtworkFetcher.h>
#import <SMP/BBCSMPNetworkStatus.h>
#import <SMP/BBCSMPNetworkStatusObserver.h>
#import <SMP/BBCSMPObserver.h>
#import <SMP/BBCSMPObserverManager.h>
#import <SMP/BBCSMPOverlayPosition.h>
#import <SMP/BBCSMPPIPSType.h>
#import <SMP/BBCSMPPictureInPictureAdapter.h>
#import <SMP/BBCSMPPictureInPictureAvailabilityObserver.h>
#import <SMP/BBCSMPPictureInPictureController.h>
#import <SMP/BBCSMPPictureInPictureObserver.h>
#import <SMP/BBCSMPPlayerBitrateObserver.h>
#import <SMP/BBCSMPPlayerBuilder.h>
#import <SMP/BBCSMPPlayerObservable.h>
#import <SMP/BBCSMPPlayerSizeObserver.h>
#import <SMP/BBCSMPPlayerState.h>
#import <SMP/BBCSMPPlayerViewFullscreenPresenter.h>
#import <SMP/BBCSMPPlugin.h>
#import <SMP/BBCSMPPluginEnvironment.h>
#import <SMP/BBCSMPPluginFactory.h>
#import <SMP/BBCSMPPreloadMetadataObserver.h>
#import <SMP/BBCSMPProtocol.h>
#import <SMP/BBCSMPRemoteCommandCenter.h>
#import <SMP/BBCSMPResolvedContent.h>
#import <SMP/BBCSMPSettingsPersistence.h>
#import <SMP/BBCSMPSettingsPersistenceFilesystem.h>
#import <SMP/BBCSMPSize.h>
#import <SMP/BBCSMPState.h>
#import <SMP/BBCSMPStateObservable.h>
#import <SMP/BBCSMPStateObserver.h>
#import <SMP/BBCSMPStaticURLArtworkURLProvider.h>
#import <SMP/BBCSMPStaticURLPlayerItemProvider.h>
#import <SMP/BBCSMPStatisticsConsumer.h>
#import <SMP/BBCSMPStreamType.h>
#import <SMP/BBCSMPNetworkSubtitleFetcher.h>
#import <SMP/BBCSMPSubtitleParser.h>
#import <SMP/BBCSMPSubtitleParserResult.h>
#import <SMP/BBCSMPSubtitle.h>
#import <SMP/BBCSMPSubtitleChunk.h>
#import <SMP/BBCSMPSubtitleFetcher.h>
#import <SMP/BBCSMPSubtitleObserver.h>
#import <SMP/BBCSMPSubtitleRegion.h>
#import <SMP/BBCSMPSubtitleScene.h>
#import <SMP/BBCSMPSubtitleView.h>
#import <SMP/BBCSMPSubtitlesUIConfiguration.h>
#import <SMP/BBCSMPSuspendMechanism.h>
#import <SMP/BBCSMPSuspendRule.h>
#import <SMP/BBCSMPTime.h>
#import <SMP/BBCSMPTimeObserver.h>
#import <SMP/BBCSMPTimeRange.h>
#import <SMP/BBCSMPTimerFactoryProtocol.h>
#import <SMP/BBCSMPTimerProtocol.h>
#import <SMP/BBCSMPTouchPassThroughView.h>
#import <SMP/BBCSMPUI.h>
#import <SMP/BBCSMPUIBuilder.h>
#import <SMP/BBCSMPUIComposer.h>
#import <SMP/BBCSMPUIConfiguration.h>
#import <SMP/BBCSMPUIDefaultConfiguration.h>
#import <SMP/BBCSMPUIEmbeddedDefaultConfiguration.h>
#import <SMP/BBCSMPUIFullscreenDefaultConfiguration.h>
#import <SMP/BBCSMPURLResolvedContent.h>
#import <SMP/BBCSMPUniversalLogWriter.h>
#import <SMP/BBCSMPUnpreparedStateListener.h>
#import <SMP/BBCSMPUserAgentProvider.h>
#import <SMP/BBCSMPUserInteractionEvent.h>
#import <SMP/BBCSMPUserInteractionObserver.h>
#import <SMP/BBCSMPUserInteractionStatisticsConsumer.h>
#import <SMP/BBCSMPVersion.h>
#import <SMP/BBCSMPVideoSurface.h>
#import <SMP/BBCSMPVideoSurfaceContext.h>
#import <SMP/BBCSMPVideoSurfaceManager.h>
#import <SMP/BBCSMPVolumeObserver.h>
#import <SMP/MPNowPlayingInfoCenterProtocol.h>
#import <SMP/BBCSMPAVObservationContext.h>
#import <SMP/BBCSMPNotificationReceptionist.h>
#import <SMP/BBCSMPWorker.h>
#import <SMP/BBCSMPAVFailedToLoadPlaylistEvent.h>
#import <SMP/BBCSMPVolumeProvider.h>
#import <SMP/BBCSMPAVRateChangedEvent.h>


