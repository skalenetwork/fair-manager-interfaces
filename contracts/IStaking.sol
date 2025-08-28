// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IStaking.sol - fair-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   fair-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   fair-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with fair-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma solidity ^0.8.24;

import {ICommittee} from "./ICommittee.sol";
import {INodes, NodeId} from "./INodes.sol";
import {IRewardWallet} from "./IRewardWallet.sol";
import {Fair} from "./units.sol";


interface IStaking {

    // =============================================================
    //                           RECEIVE
    // =============================================================

    receive() external payable;

    // =============================================================
    //                       WRITE FUNCTIONS
    // =============================================================

    function initialize(
        address initialAuthority,
        ICommittee committee,
        INodes nodes,
        IRewardWallet rewardWalletReference
    ) external;

    function addAllowedReceiver(address receiver) external;
    function claimAllFees() external;
    function claimFees(bytes32 requestId) external;
    function disable(NodeId node) external;
    function enable(NodeId node) external;
    function nodeCreated(NodeId node) external;
    function nodeRemoved(NodeId node) external;
    function payReward(NodeId node) external payable;
    function removeAllowedReceiver(address receiver) external;
    function requestClaimAllFees(NodeId node) external;
    function requestClaimFees(NodeId node, Fair amount) external;
    function requestRetrieve(NodeId node, Fair value) external;
    function requestSendAllFees(address payable to) external;
    function requestSendFees(address payable to, Fair amount) external;
    function retrieve(bytes32 requestId) external;
    function retrieveAll() external;
    function setFeeRate(uint16 feeRate) external;
    function setMaxAllowedExitRequests(uint256 amount) external;
    function setRetrievingDelay(uint256 delay) external;
    function setRewardWalletReference(IRewardWallet rewardWalletReference_) external;
    function setStakeLimit(Fair limit) external;
    function stake(NodeId node) external payable;

    // =============================================================
    //                       READ FUNCTIONS
    // =============================================================

    function getDelegatorsToNode(NodeId node) external view returns (address[] memory delegators);
    function getDelegatorsToNodeCount(NodeId node) external view returns (uint256 count);
    function getEarnedFeeAmount(NodeId node) external view returns (Fair amount);
    function getFeesExitRequest(address user, bytes32 requestId) external view returns (Fair amount, uint256 unlockDate);
    function getLockedFeesAmountFor(address user) external view returns (Fair amount);
    function getLockedStakeAmountFor(address user) external view returns (Fair amount);
    function getLockedFeesRequestsFor(address user) external view returns (bytes32[] memory requestIds);
    function getLockedStakeRequestsFor(address user) external view returns (bytes32[] memory requestIds);
    function getMyLockedFeesAmount() external view returns (Fair amount);
    function getMyLockedStakeAmount() external view returns (Fair amount);
    function getMyLockedFeesRequests() external view returns (bytes32[] memory requestIds);
    function getMyLockedStakeRequests() external view returns (bytes32[] memory requestIds);
    function getMyUnlockedFeesAmount() external view returns (Fair amount);
    function getMyUnlockedStakeAmount() external view returns (Fair amount);
    function getMyUnlockedFeesRequests() external view returns (bytes32[] memory requestIds);
    function getMyUnlockedStakeRequests() external view returns (bytes32[] memory requestIds);
    function getNodeFeeRate(NodeId node) external view returns (uint16 feeRate);
    function getNodeShare(NodeId node) external view returns (uint256 share);
    function getNodeTotalStake(NodeId node) external view returns (Fair amount);
    function getMaxExitRequests() external view returns (uint256 numRequests);
    function getRetrievingDelay() external view returns (uint256 delay);
    function getRewardWallet(NodeId node) external view returns (IRewardWallet rewardWallet);
    function getStakeExitRequest(address user, bytes32 requestId) external view returns (Fair amount, uint256 unlockDate);
    function getStakedAmount() external view returns (Fair amount);
    function getStakedAmountFor(address holder) external view returns (Fair amount);
    function getStakedNodes() external view returns (NodeId[] memory stakedNodes);
    function getStakedNodesFor(address holder) external view returns (NodeId[] memory stakedNodes);
    function getStakedToNodeAmount(NodeId node) external view returns (Fair amount);
    function getStakedToNodeAmountFor(NodeId node, address holder) external view returns (Fair amount);
    function getTotalInExitQueue() external view returns (Fair amount);
    function getUnlockedFeesAmountFor(address user) external view returns (Fair amount);
    function getUnlockedStakeAmountFor(address user) external view returns (Fair amount);
    function getUnlockedFeesRequestsFor(address user) external view returns (bytes32[] memory requestIds);
    function getUnlockedStakeRequestsFor(address user) external view returns (bytes32[] memory requestIds);
    function isNodeEnabled(NodeId node) external view returns (bool enabled);
}
